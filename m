Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753150AbeDCTR4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 15:17:56 -0400
Received: from zimbra.mrvanes.com ([94.103.150.236]:45064 "EHLO
        zimbra.mrvanes.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751496AbeDCTRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 15:17:54 -0400
From: Martin van Es <martin@mrvanes.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Martin <bugs@mrvanes.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: input: fix battery level reporting on BT mice
Date: Tue, 03 Apr 2018 21:08:08 +0200
Message-ID: <10651380.a6EbCRfp8J@minivanes>
In-Reply-To: <20180403175220.GA148162@dtor-ws>
References: <20180403175220.GA148162@dtor-ws>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart1806796.A55lLHr2zl"
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--nextPart1806796.A55lLHr2zl
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Dimitry,

I reapplied the 3 commits I had to revert earlier and applied your patch. Have 
correct battery level reading on my BT mouse back!

/sys/class/power_supply/hid-00:1f:20:fd:cb:be-battery# grep "" *
capacity:53
grep: device: Is a directory
model_name:Bluetooth Mouse M336/M337/M535
online:1
grep: power: Is a directory
grep: powers: Is a directory
present:1
scope:Device
status:Discharging
grep: subsystem: Is a directory
type:Battery
uevent:POWER_SUPPLY_NAME=hid-00:1f:20:fd:cb:be-battery
uevent:POWER_SUPPLY_PRESENT=1
uevent:POWER_SUPPLY_ONLINE=1
uevent:POWER_SUPPLY_CAPACITY=53
uevent:POWER_SUPPLY_MODEL_NAME=Bluetooth Mouse M336/M337/M535
uevent:POWER_SUPPLY_STATUS=Discharging
uevent:POWER_SUPPLY_SCOPE=Device

rdesc file is attached

Thx for the effort!

Best regards,
Martin van Es

On Tuesday, April 3, 2018 7:52:20 PM CEST Dmitry Torokhov wrote:
> The commit 581c4484769e ("HID: input: map digitizer battery usage")
> assumed that devices having input (qas opposed to feature) report for
> battery strength would report the data on their own, without the need to
> be polled by the kernel; unfortunately it is not so. Many wireless mice
> do not send unsolicited reports with battery strength data and have to
> be polled explicitly. As a complication, stylus devices on digitizers
> are not normally connected to the base and thus can not be polled - the
> base can only determine battery strength in the stylus when it is in
> proximity.
> 
> To solve this issue, we add a special flag that tells the kernel
> to avoid polling the device (and expect unsolicited reports) and set it
> when report field with physical usage of digitizer stylus (HID_DG_STYLUS).
> Unless this flag is set, and we have not seen the unsolicited reports,
> the kernel will attempt to poll the device when userspace attempts to
> read "capacity" and "state" attributes of power_supply object
> corresponding to the devices battery.
> 
> Fixes: 581c4484769e ("HID: input: map digitizer battery usage")
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=198095
> Cc: stable@vger.kernel.org
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> 
> Martin, give this patch a try and reply with your name/email if you
> want to be credited for reporting/testing.
> 
> Thanks!
> 
>  drivers/hid/hid-input.c | 24 +++++++++++++++++-------
>  include/linux/hid.h     |  9 ++++++++-
>  2 files changed, 25 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index 6836a856c243..930652c25120 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -387,7 +387,8 @@ static int hidinput_get_battery_property(struct
> power_supply *psy, break;
> 
>  	case POWER_SUPPLY_PROP_CAPACITY:
> -		if (dev->battery_report_type == HID_FEATURE_REPORT) {
> +		if (dev->battery_status != HID_BATTERY_REPORTED &&
> +		    !dev->battery_avoid_query) {
>  			value = hidinput_query_battery_capacity(dev);
>  			if (value < 0)
>  				return value;
> @@ -403,17 +404,17 @@ static int hidinput_get_battery_property(struct
> power_supply *psy, break;
> 
>  	case POWER_SUPPLY_PROP_STATUS:
> -		if (!dev->battery_reported &&
> -		    dev->battery_report_type == HID_FEATURE_REPORT) {
> +		if (dev->battery_status != HID_BATTERY_REPORTED &&
> +		    !dev->battery_avoid_query) {
>  			value = hidinput_query_battery_capacity(dev);
>  			if (value < 0)
>  				return value;
> 
>  			dev->battery_capacity = value;
> -			dev->battery_reported = true;
> +			dev->battery_status = HID_BATTERY_QUERIED;
>  		}
> 
> -		if (!dev->battery_reported)
> +		if (dev->battery_status == HID_BATTERY_UNKNOWN)
>  			val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
>  		else if (dev->battery_capacity == 100)
>  			val->intval = POWER_SUPPLY_STATUS_FULL;
> @@ -486,6 +487,14 @@ static int hidinput_setup_battery(struct hid_device
> *dev, unsigned report_type, dev->battery_report_type = report_type;
>  	dev->battery_report_id = field->report->id;
> 
> +	/*
> +	 * Stylus is normally not connected to the device and thus we
> +	 * can't query the device and get meaningful battery strength.
> +	 * We have to wait for the device to report it on its own.
> +	 */
> +	dev->battery_avoid_query = report_type == HID_INPUT_REPORT &&
> +				   field->physical == HID_DG_STYLUS;
> +
>  	dev->battery = power_supply_register(&dev->dev, psy_desc, &psy_cfg);
>  	if (IS_ERR(dev->battery)) {
>  		error = PTR_ERR(dev->battery);
> @@ -530,9 +539,10 @@ static void hidinput_update_battery(struct hid_device
> *dev, int value)
> 
>  	capacity = hidinput_scale_battery_capacity(dev, value);
> 
> -	if (!dev->battery_reported || capacity != dev->battery_capacity) {
> +	if (dev->battery_status != HID_BATTERY_REPORTED ||
> +	    capacity != dev->battery_capacity) {
>  		dev->battery_capacity = capacity;
> -		dev->battery_reported = true;
> +		dev->battery_status = HID_BATTERY_REPORTED;
>  		power_supply_changed(dev->battery);
>  	}
>  }
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index 8da3e1f48195..26240a22978a 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -516,6 +516,12 @@ enum hid_type {
>  	HID_TYPE_USBNONE
>  };
> 
> +enum hid_battery_status {
> +	HID_BATTERY_UNKNOWN = 0,
> +	HID_BATTERY_QUERIED,		/* Kernel explicitly queried battery strength */
> +	HID_BATTERY_REPORTED,		/* Device sent unsolicited battery strength 
report
> */ +};
> +
>  struct hid_driver;
>  struct hid_ll_driver;
> 
> @@ -558,7 +564,8 @@ struct hid_device {							/* device report 
descriptor */
> __s32 battery_max;
>  	__s32 battery_report_type;
>  	__s32 battery_report_id;
> -	bool battery_reported;
> +	enum hid_battery_status battery_status;
> +	bool battery_avoid_query;
>  #endif
> 
>  	unsigned int status;						/* see STAT flags above */

--nextPart1806796.A55lLHr2zl
Content-Disposition: attachment; filename="rdesc"
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"; name="rdesc"

05 01 09 02 a1 01 85 02 09 01 a1 00 05 09 19 01 29 08 15 00 25 01 75 01 95 08 81 02 05 01 09 30 09 31 16 01 f8 26 ff 07 75 0c 95 02 81 06 09 38 15 81 25 7f 75 08 95 01 81 06 05 0c 0a 38 02 75 08 95 01 81 06 c0 c0 05 0c 09 01 a1 01 85 03 05 06 09 20 15 00 26 64 00 75 08 95 01 81 02 c0 06 00 ff 09 01 a1 01 85 10 75 08 95 06 15 00 26 ff 00 09 01 81 00 09 01 91 00 c0 06 00 ff 09 02 a1 01 85 11 75 08 95 13 15 00 26 ff 00 09 02 81 00 09 02 91 00 c0 05 01 09 06 a1 01 85 04 75 01 95 08 05 07 19 e0 29 e7 15 00 25 01 81 02 95 01 75 08 81 03 95 05 75 01 05 08 19 01 29 05 91 02 95 01 75 03 91 03 95 06 75 08 15 00 26 ff 00 05 07 19 00 29 ff 81 00 c0 05 0c 09 01 a1 01 85 05 15 00 25 01 75 01 95 02 0a 25 02 0a 24 02 81 02 95 01 75 06 81 03 c0 00 

  INPUT(2)[INPUT]
    Field(0)
      Physical(GenericDesktop.Pointer)
      Application(GenericDesktop.Mouse)
      Usage(8)
        Button.0001
        Button.0002
        Button.0003
        Button.0004
        Button.0005
        Button.0006
        Button.0007
        Button.0008
      Logical Minimum(0)
      Logical Maximum(1)
      Report Size(1)
      Report Count(8)
      Report Offset(0)
      Flags( Variable Absolute )
    Field(1)
      Physical(GenericDesktop.Pointer)
      Application(GenericDesktop.Mouse)
      Usage(2)
        GenericDesktop.X
        GenericDesktop.Y
      Logical Minimum(-2047)
      Logical Maximum(2047)
      Report Size(12)
      Report Count(2)
      Report Offset(8)
      Flags( Variable Relative )
    Field(2)
      Physical(GenericDesktop.Pointer)
      Application(GenericDesktop.Mouse)
      Usage(1)
        GenericDesktop.Wheel
      Logical Minimum(-127)
      Logical Maximum(127)
      Report Size(8)
      Report Count(1)
      Report Offset(32)
      Flags( Variable Relative )
    Field(3)
      Physical(GenericDesktop.Pointer)
      Application(GenericDesktop.Mouse)
      Usage(1)
        Consumer.HorizontalWheel
      Logical Minimum(-127)
      Logical Maximum(127)
      Report Size(8)
      Report Count(1)
      Report Offset(40)
      Flags( Variable Relative )
  INPUT(3)[INPUT]
    Field(0)
      Application(Consumer.0001)
      Usage(1)
        GenericDeviceControls.BatteryStrength
      Logical Minimum(0)
      Logical Maximum(100)
      Report Size(8)
      Report Count(1)
      Report Offset(0)
      Flags( Variable Absolute )
  INPUT(16)[INPUT]
    Field(0)
      Application(ff00.0001)
      Usage(6)
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
      Logical Minimum(0)
      Logical Maximum(255)
      Report Size(8)
      Report Count(6)
      Report Offset(0)
      Flags( Array Absolute )
  INPUT(17)[INPUT]
    Field(0)
      Application(ff00.0002)
      Usage(19)
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
      Logical Minimum(0)
      Logical Maximum(255)
      Report Size(8)
      Report Count(19)
      Report Offset(0)
      Flags( Array Absolute )
  INPUT(4)[INPUT]
    Field(0)
      Application(GenericDesktop.Keyboard)
      Usage(8)
        Keyboard.00e0
        Keyboard.00e1
        Keyboard.00e2
        Keyboard.00e3
        Keyboard.00e4
        Keyboard.00e5
        Keyboard.00e6
        Keyboard.00e7
      Logical Minimum(0)
      Logical Maximum(1)
      Report Size(1)
      Report Count(8)
      Report Offset(0)
      Flags( Variable Absolute )
    Field(1)
      Application(GenericDesktop.Keyboard)
      Usage(256)
        Keyboard.0000
        Keyboard.0001
        Keyboard.0002
        Keyboard.0003
        Keyboard.0004
        Keyboard.0005
        Keyboard.0006
        Keyboard.0007
        Keyboard.0008
        Keyboard.0009
        Keyboard.000a
        Keyboard.000b
        Keyboard.000c
        Keyboard.000d
        Keyboard.000e
        Keyboard.000f
        Keyboard.0010
        Keyboard.0011
        Keyboard.0012
        Keyboard.0013
        Keyboard.0014
        Keyboard.0015
        Keyboard.0016
        Keyboard.0017
        Keyboard.0018
        Keyboard.0019
        Keyboard.001a
        Keyboard.001b
        Keyboard.001c
        Keyboard.001d
        Keyboard.001e
        Keyboard.001f
        Keyboard.0020
        Keyboard.0021
        Keyboard.0022
        Keyboard.0023
        Keyboard.0024
        Keyboard.0025
        Keyboard.0026
        Keyboard.0027
        Keyboard.0028
        Keyboard.0029
        Keyboard.002a
        Keyboard.002b
        Keyboard.002c
        Keyboard.002d
        Keyboard.002e
        Keyboard.002f
        Keyboard.0030
        Keyboard.0031
        Keyboard.0032
        Keyboard.0033
        Keyboard.0034
        Keyboard.0035
        Keyboard.0036
        Keyboard.0037
        Keyboard.0038
        Keyboard.0039
        Keyboard.003a
        Keyboard.003b
        Keyboard.003c
        Keyboard.003d
        Keyboard.003e
        Keyboard.003f
        Keyboard.0040
        Keyboard.0041
        Keyboard.0042
        Keyboard.0043
        Keyboard.0044
        Keyboard.0045
        Keyboard.0046
        Keyboard.0047
        Keyboard.0048
        Keyboard.0049
        Keyboard.004a
        Keyboard.004b
        Keyboard.004c
        Keyboard.004d
        Keyboard.004e
        Keyboard.004f
        Keyboard.0050
        Keyboard.0051
        Keyboard.0052
        Keyboard.0053
        Keyboard.0054
        Keyboard.0055
        Keyboard.0056
        Keyboard.0057
        Keyboard.0058
        Keyboard.0059
        Keyboard.005a
        Keyboard.005b
        Keyboard.005c
        Keyboard.005d
        Keyboard.005e
        Keyboard.005f
        Keyboard.0060
        Keyboard.0061
        Keyboard.0062
        Keyboard.0063
        Keyboard.0064
        Keyboard.0065
        Keyboard.0066
        Keyboard.0067
        Keyboard.0068
        Keyboard.0069
        Keyboard.006a
        Keyboard.006b
        Keyboard.006c
        Keyboard.006d
        Keyboard.006e
        Keyboard.006f
        Keyboard.0070
        Keyboard.0071
        Keyboard.0072
        Keyboard.0073
        Keyboard.0074
        Keyboard.0075
        Keyboard.0076
        Keyboard.0077
        Keyboard.0078
        Keyboard.0079
        Keyboard.007a
        Keyboard.007b
        Keyboard.007c
        Keyboard.007d
        Keyboard.007e
        Keyboard.007f
        Keyboard.0080
        Keyboard.0081
        Keyboard.0082
        Keyboard.0083
        Keyboard.0084
        Keyboard.0085
        Keyboard.0086
        Keyboard.0087
        Keyboard.0088
        Keyboard.0089
        Keyboard.008a
        Keyboard.008b
        Keyboard.008c
        Keyboard.008d
        Keyboard.008e
        Keyboard.008f
        Keyboard.0090
        Keyboard.0091
        Keyboard.0092
        Keyboard.0093
        Keyboard.0094
        Keyboard.0095
        Keyboard.0096
        Keyboard.0097
        Keyboard.0098
        Keyboard.0099
        Keyboard.009a
        Keyboard.009b
        Keyboard.009c
        Keyboard.009d
        Keyboard.009e
        Keyboard.009f
        Keyboard.00a0
        Keyboard.00a1
        Keyboard.00a2
        Keyboard.00a3
        Keyboard.00a4
        Keyboard.00a5
        Keyboard.00a6
        Keyboard.00a7
        Keyboard.00a8
        Keyboard.00a9
        Keyboard.00aa
        Keyboard.00ab
        Keyboard.00ac
        Keyboard.00ad
        Keyboard.00ae
        Keyboard.00af
        Keyboard.00b0
        Keyboard.00b1
        Keyboard.00b2
        Keyboard.00b3
        Keyboard.00b4
        Keyboard.00b5
        Keyboard.00b6
        Keyboard.00b7
        Keyboard.00b8
        Keyboard.00b9
        Keyboard.00ba
        Keyboard.00bb
        Keyboard.00bc
        Keyboard.00bd
        Keyboard.00be
        Keyboard.00bf
        Keyboard.00c0
        Keyboard.00c1
        Keyboard.00c2
        Keyboard.00c3
        Keyboard.00c4
        Keyboard.00c5
        Keyboard.00c6
        Keyboard.00c7
        Keyboard.00c8
        Keyboard.00c9
        Keyboard.00ca
        Keyboard.00cb
        Keyboard.00cc
        Keyboard.00cd
        Keyboard.00ce
        Keyboard.00cf
        Keyboard.00d0
        Keyboard.00d1
        Keyboard.00d2
        Keyboard.00d3
        Keyboard.00d4
        Keyboard.00d5
        Keyboard.00d6
        Keyboard.00d7
        Keyboard.00d8
        Keyboard.00d9
        Keyboard.00da
        Keyboard.00db
        Keyboard.00dc
        Keyboard.00dd
        Keyboard.00de
        Keyboard.00df
        Keyboard.00e0
        Keyboard.00e1
        Keyboard.00e2
        Keyboard.00e3
        Keyboard.00e4
        Keyboard.00e5
        Keyboard.00e6
        Keyboard.00e7
        Keyboard.00e8
        Keyboard.00e9
        Keyboard.00ea
        Keyboard.00eb
        Keyboard.00ec
        Keyboard.00ed
        Keyboard.00ee
        Keyboard.00ef
        Keyboard.00f0
        Keyboard.00f1
        Keyboard.00f2
        Keyboard.00f3
        Keyboard.00f4
        Keyboard.00f5
        Keyboard.00f6
        Keyboard.00f7
        Keyboard.00f8
        Keyboard.00f9
        Keyboard.00fa
        Keyboard.00fb
        Keyboard.00fc
        Keyboard.00fd
        Keyboard.00fe
        Keyboard.00ff
      Logical Minimum(0)
      Logical Maximum(255)
      Report Size(8)
      Report Count(6)
      Report Offset(16)
      Flags( Array Absolute )
  INPUT(5)[INPUT]
    Field(0)
      Application(Consumer.0001)
      Usage(2)
        Consumer.0225
        Consumer.0224
      Logical Minimum(0)
      Logical Maximum(1)
      Report Size(1)
      Report Count(2)
      Report Offset(0)
      Flags( Variable Absolute )
  OUTPUT(16)[OUTPUT]
    Field(0)
      Application(ff00.0001)
      Usage(6)
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
      Logical Minimum(0)
      Logical Maximum(255)
      Report Size(8)
      Report Count(6)
      Report Offset(0)
      Flags( Array Absolute )
  OUTPUT(17)[OUTPUT]
    Field(0)
      Application(ff00.0002)
      Usage(19)
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
      Logical Minimum(0)
      Logical Maximum(255)
      Report Size(8)
      Report Count(19)
      Report Offset(0)
      Flags( Array Absolute )
  OUTPUT(4)[OUTPUT]
    Field(0)
      Application(GenericDesktop.Keyboard)
      Usage(5)
        LED.NumLock
        LED.CapsLock
        LED.ScrollLock
        LED.Compose
        LED.Kana
      Logical Minimum(0)
      Logical Maximum(1)
      Report Size(1)
      Report Count(5)
      Report Offset(0)
      Flags( Variable Absolute )

Button.0001 ---> Key.LeftBtn
Button.0002 ---> Key.RightBtn
Button.0003 ---> Key.MiddleBtn
Button.0004 ---> Key.SideBtn
Button.0005 ---> Key.ExtraBtn
Button.0006 ---> Key.ForwardBtn
Button.0007 ---> Key.BackBtn
Button.0008 ---> Key.TaskBtn
GenericDesktop.X ---> Relative.X
GenericDesktop.Y ---> Relative.Y
GenericDesktop.Wheel ---> Relative.Wheel
Consumer.HorizontalWheel ---> Relative.HWheel
GenericDeviceControls.BatteryStrength ---> Power.?
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
Keyboard.00e0 ---> Key.LeftControl
Keyboard.00e1 ---> Key.LeftShift
Keyboard.00e2 ---> Key.LeftAlt
Keyboard.00e3 ---> Key.LeftMeta
Keyboard.00e4 ---> Key.RightCtrl
Keyboard.00e5 ---> Key.RightShift
Keyboard.00e6 ---> Key.RightAlt
Keyboard.00e7 ---> Key.RightMeta
Keyboard.0000 ---> Sync.Report
Keyboard.0001 ---> Sync.Report
Keyboard.0002 ---> Sync.Report
Keyboard.0003 ---> Sync.Report
Keyboard.0004 ---> Key.A
Keyboard.0005 ---> Key.B
Keyboard.0006 ---> Key.C
Keyboard.0007 ---> Key.D
Keyboard.0008 ---> Key.E
Keyboard.0009 ---> Key.F
Keyboard.000a ---> Key.G
Keyboard.000b ---> Key.H
Keyboard.000c ---> Key.I
Keyboard.000d ---> Key.J
Keyboard.000e ---> Key.K
Keyboard.000f ---> Key.L
Keyboard.0010 ---> Key.M
Keyboard.0011 ---> Key.N
Keyboard.0012 ---> Key.O
Keyboard.0013 ---> Key.P
Keyboard.0014 ---> Key.Q
Keyboard.0015 ---> Key.R
Keyboard.0016 ---> Key.S
Keyboard.0017 ---> Key.T
Keyboard.0018 ---> Key.U
Keyboard.0019 ---> Key.V
Keyboard.001a ---> Key.W
Keyboard.001b ---> Key.X
Keyboard.001c ---> Key.Y
Keyboard.001d ---> Key.Z
Keyboard.001e ---> Key.1
Keyboard.001f ---> Key.2
Keyboard.0020 ---> Key.3
Keyboard.0021 ---> Key.4
Keyboard.0022 ---> Key.5
Keyboard.0023 ---> Key.6
Keyboard.0024 ---> Key.7
Keyboard.0025 ---> Key.8
Keyboard.0026 ---> Key.9
Keyboard.0027 ---> Key.0
Keyboard.0028 ---> Key.Enter
Keyboard.0029 ---> Key.Esc
Keyboard.002a ---> Key.Backspace
Keyboard.002b ---> Key.Tab
Keyboard.002c ---> Key.Space
Keyboard.002d ---> Key.Minus
Keyboard.002e ---> Key.Equal
Keyboard.002f ---> Key.LeftBrace
Keyboard.0030 ---> Key.RightBrace
Keyboard.0031 ---> Key.BackSlash
Keyboard.0032 ---> Key.BackSlash
Keyboard.0033 ---> Key.Semicolon
Keyboard.0034 ---> Key.Apostrophe
Keyboard.0035 ---> Key.Grave
Keyboard.0036 ---> Key.Comma
Keyboard.0037 ---> Key.Dot
Keyboard.0038 ---> Key.Slash
Keyboard.0039 ---> Key.CapsLock
Keyboard.003a ---> Key.F1
Keyboard.003b ---> Key.F2
Keyboard.003c ---> Key.F3
Keyboard.003d ---> Key.F4
Keyboard.003e ---> Key.F5
Keyboard.003f ---> Key.F6
Keyboard.0040 ---> Key.F7
Keyboard.0041 ---> Key.F8
Keyboard.0042 ---> Key.F9
Keyboard.0043 ---> Key.F10
Keyboard.0044 ---> Key.F11
Keyboard.0045 ---> Key.F12
Keyboard.0046 ---> Key.SysRq
Keyboard.0047 ---> Key.ScrollLock
Keyboard.0048 ---> Key.Pause
Keyboard.0049 ---> Key.Insert
Keyboard.004a ---> Key.Home
Keyboard.004b ---> Key.PageUp
Keyboard.004c ---> Key.Delete
Keyboard.004d ---> Key.End
Keyboard.004e ---> Key.PageDown
Keyboard.004f ---> Key.Right
Keyboard.0050 ---> Key.Left
Keyboard.0051 ---> Key.Down
Keyboard.0052 ---> Key.Up
Keyboard.0053 ---> Key.NumLock
Keyboard.0054 ---> Key.KPSlash
Keyboard.0055 ---> Key.KPAsterisk
Keyboard.0056 ---> Key.KPMinus
Keyboard.0057 ---> Key.KPPlus
Keyboard.0058 ---> Key.KPEnter
Keyboard.0059 ---> Key.KP1
Keyboard.005a ---> Key.KP2
Keyboard.005b ---> Key.KP3
Keyboard.005c ---> Key.KP4
Keyboard.005d ---> Key.KP5
Keyboard.005e ---> Key.KP6
Keyboard.005f ---> Key.KP7
Keyboard.0060 ---> Key.KP8
Keyboard.0061 ---> Key.KP9
Keyboard.0062 ---> Key.KP0
Keyboard.0063 ---> Key.KPDot
Keyboard.0064 ---> Key.102nd
Keyboard.0065 ---> Key.Compose
Keyboard.0066 ---> Key.Power
Keyboard.0067 ---> Key.KPEqual
Keyboard.0068 ---> Key.F13
Keyboard.0069 ---> Key.F14
Keyboard.006a ---> Key.F15
Keyboard.006b ---> Key.F16
Keyboard.006c ---> Key.F17
Keyboard.006d ---> Key.F18
Keyboard.006e ---> Key.F19
Keyboard.006f ---> Key.F20
Keyboard.0070 ---> Key.F21
Keyboard.0071 ---> Key.F22
Keyboard.0072 ---> Key.F23
Keyboard.0073 ---> Key.F24
Keyboard.0074 ---> Key.Open
Keyboard.0075 ---> Key.Help
Keyboard.0076 ---> Key.Props
Keyboard.0077 ---> Key.Front
Keyboard.0078 ---> Key.Stop
Keyboard.0079 ---> Key.Again
Keyboard.007a ---> Key.Undo
Keyboard.007b ---> Key.Cut
Keyboard.007c ---> Key.Copy
Keyboard.007d ---> Key.Paste
Keyboard.007e ---> Key.Find
Keyboard.007f ---> Key.Mute
Keyboard.0080 ---> Key.VolumeUp
Keyboard.0081 ---> Key.VolumeDown
Keyboard.0082 ---> Key.Unknown
Keyboard.0083 ---> Key.Unknown
Keyboard.0084 ---> Key.Unknown
Keyboard.0085 ---> Key.KPComma
Keyboard.0086 ---> Key.Unknown
Keyboard.0087 ---> Key.RO
Keyboard.0088 ---> Key.Katakana/Hiragana
Keyboard.0089 ---> Key.Yen
Keyboard.008a ---> Key.Henkan
Keyboard.008b ---> Key.Muhenkan
Keyboard.008c ---> Key.KPJpComma
Keyboard.008d ---> Key.Unknown
Keyboard.008e ---> Key.Unknown
Keyboard.008f ---> Key.Unknown
Keyboard.0090 ---> Key.Hangeul
Keyboard.0091 ---> Key.Hanja
Keyboard.0092 ---> Key.Katakana
Keyboard.0093 ---> Key.HIRAGANA
Keyboard.0094 ---> Key.Zenkaku/Hankaku
Keyboard.0095 ---> Key.Unknown
Keyboard.0096 ---> Key.Unknown
Keyboard.0097 ---> Key.Unknown
Keyboard.0098 ---> Key.Unknown
Keyboard.0099 ---> Key.Unknown
Keyboard.009a ---> Key.Unknown
Keyboard.009b ---> Key.Unknown
Keyboard.009c ---> Key.Delete
Keyboard.009d ---> Key.Unknown
Keyboard.009e ---> Key.Unknown
Keyboard.009f ---> Key.Unknown
Keyboard.00a0 ---> Key.Unknown
Keyboard.00a1 ---> Key.Unknown
Keyboard.00a2 ---> Key.Unknown
Keyboard.00a3 ---> Key.Unknown
Keyboard.00a4 ---> Key.Unknown
Keyboard.00a5 ---> Key.Unknown
Keyboard.00a6 ---> Key.Unknown
Keyboard.00a7 ---> Key.Unknown
Keyboard.00a8 ---> Key.Unknown
Keyboard.00a9 ---> Key.Unknown
Keyboard.00aa ---> Key.Unknown
Keyboard.00ab ---> Key.Unknown
Keyboard.00ac ---> Key.Unknown
Keyboard.00ad ---> Key.Unknown
Keyboard.00ae ---> Key.Unknown
Keyboard.00af ---> Key.Unknown
Keyboard.00b0 ---> Key.Unknown
Keyboard.00b1 ---> Key.Unknown
Keyboard.00b2 ---> Key.Unknown
Keyboard.00b3 ---> Key.Unknown
Keyboard.00b4 ---> Key.Unknown
Keyboard.00b5 ---> Key.Unknown
Keyboard.00b6 ---> Key.KPLeftParenthesis
Keyboard.00b7 ---> Key.KPRightParenthesis
Keyboard.00b8 ---> Key.Unknown
Keyboard.00b9 ---> Key.Unknown
Keyboard.00ba ---> Key.Unknown
Keyboard.00bb ---> Key.Unknown
Keyboard.00bc ---> Key.Unknown
Keyboard.00bd ---> Key.Unknown
Keyboard.00be ---> Key.Unknown
Keyboard.00bf ---> Key.Unknown
Keyboard.00c0 ---> Key.Unknown
Keyboard.00c1 ---> Key.Unknown
Keyboard.00c2 ---> Key.Unknown
Keyboard.00c3 ---> Key.Unknown
Keyboard.00c4 ---> Key.Unknown
Keyboard.00c5 ---> Key.Unknown
Keyboard.00c6 ---> Key.Unknown
Keyboard.00c7 ---> Key.Unknown
Keyboard.00c8 ---> Key.Unknown
Keyboard.00c9 ---> Key.Unknown
Keyboard.00ca ---> Key.Unknown
Keyboard.00cb ---> Key.Unknown
Keyboard.00cc ---> Key.Unknown
Keyboard.00cd ---> Key.Unknown
Keyboard.00ce ---> Key.Unknown
Keyboard.00cf ---> Key.Unknown
Keyboard.00d0 ---> Key.Unknown
Keyboard.00d1 ---> Key.Unknown
Keyboard.00d2 ---> Key.Unknown
Keyboard.00d3 ---> Key.Unknown
Keyboard.00d4 ---> Key.Unknown
Keyboard.00d5 ---> Key.Unknown
Keyboard.00d6 ---> Key.Unknown
Keyboard.00d7 ---> Key.Unknown
Keyboard.00d8 ---> Key.Delete
Keyboard.00d9 ---> Key.Unknown
Keyboard.00da ---> Key.Unknown
Keyboard.00db ---> Key.Unknown
Keyboard.00dc ---> Key.Unknown
Keyboard.00dd ---> Key.Unknown
Keyboard.00de ---> Key.Unknown
Keyboard.00df ---> Key.Unknown
Keyboard.00e0 ---> Key.LeftControl
Keyboard.00e1 ---> Key.LeftShift
Keyboard.00e2 ---> Key.LeftAlt
Keyboard.00e3 ---> Key.LeftMeta
Keyboard.00e4 ---> Key.RightCtrl
Keyboard.00e5 ---> Key.RightShift
Keyboard.00e6 ---> Key.RightAlt
Keyboard.00e7 ---> Key.RightMeta
Keyboard.00e8 ---> Key.PlayPause
Keyboard.00e9 ---> Key.StopCD
Keyboard.00ea ---> Key.PreviousSong
Keyboard.00eb ---> Key.NextSong
Keyboard.00ec ---> Key.EjectCD
Keyboard.00ed ---> Key.VolumeUp
Keyboard.00ee ---> Key.VolumeDown
Keyboard.00ef ---> Key.Mute
Keyboard.00f0 ---> Key.WWW
Keyboard.00f1 ---> Key.Back
Keyboard.00f2 ---> Key.Forward
Keyboard.00f3 ---> Key.Stop
Keyboard.00f4 ---> Key.Find
Keyboard.00f5 ---> Key.ScrollUp
Keyboard.00f6 ---> Key.ScrollDown
Keyboard.00f7 ---> Key.Edit
Keyboard.00f8 ---> Key.Sleep
Keyboard.00f9 ---> Key.Coffee
Keyboard.00fa ---> Key.Refresh
Keyboard.00fb ---> Key.Calc
Keyboard.00fc ---> Key.Unknown
Keyboard.00fd ---> Key.Unknown
Keyboard.00fe ---> Key.Unknown
Keyboard.00ff ---> Key.Unknown
Consumer.0225 ---> Key.Forward
Consumer.0224 ---> Key.Back
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
LED.NumLock ---> LED.NumLock
LED.CapsLock ---> LED.CapsLock
LED.ScrollLock ---> LED.ScrollLock
LED.Compose ---> LED.Compose
LED.Kana ---> LED.Kana

--nextPart1806796.A55lLHr2zl--
