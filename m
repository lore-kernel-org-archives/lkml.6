Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDBFC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 22:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D6CB20836
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 22:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfALWEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 17:04:43 -0500
Received: from dnvrco-outbound-snat.email.rr.com ([107.14.73.227]:28361 "EHLO
        dnvrco-cmomta01.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726387AbfALWEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 17:04:42 -0500
Received: from [192.168.1.87] ([70.114.195.161])
        by cmsmtp with ESMTPA
        id iROPgFzOUP088iRORgURBQ; Sat, 12 Jan 2019 22:04:41 +0000
Subject: Re: [PATCH] Input: synaptics - add PNP IDs for Dell XPS models to
 forcepad
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
References: <20190111205430.15371-1-kim@kimphillips.com>
 <20190112014004.GA122403@dtor-ws>
From:   Kim Phillips <kim@kimphillips.com>
Message-ID: <22e2d619-0622-1816-2057-c9005288b46b@kimphillips.com>
Date:   Sat, 12 Jan 2019 16:04:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190112014004.GA122403@dtor-ws>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfEIFyKoIkw2KeB7CtD12PzO1y767hEuCmQwNt+ByBGDm6CYj8pdKG6JTlE5nAwz+/qPFTWLS1s8biXyX2pQgR91FIB0zbMkgc+hOXThj3KCb+uD6yep1
 xmI13G5QktNNMM5lJqafNqNjOSpzq4NCKBUzmxLA5oyDKzR5jbkHU+3PZAguBaTFqng4J87iJwczPqM3xikqOj7065sRlVcQq9JwYWCJinTjsEpEI4YPrF9v
 5JxF49hv5T4PVmZm5UhmABZ6k6wNoduvGpfdmGIvTm5RwzREgDTJVIIfb2bN6IHZhsmR7ZmJVp4VEcNVEeLtVCRPs7Db1k2emp4YvYcUmkI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/19 7:40 PM, Dmitry Torokhov wrote:
> Hi Kim,

Hi Dmitry,

> On Fri, Jan 11, 2019 at 02:54:30PM -0600, Kim Phillips wrote:
>> This patch is the result of seeing this message:
>>
>> psmouse serio1: synaptics: Your touchpad (PNP: DLL087c PNP0f13) says it can support a different bus. If i2c-hid and hid-rmi are not used, you might want to try setting psmouse.synaptics_intertouch to 1 and report this to linux-input@vger.kernel.org.
>>
>> If I set psmouse.synaptics_intertouch=1, or add the PNP ID to
>> smbus_pnp_ids, the touchpad continues to work, and the above message
>> goes away, but we now get:
>>
>> psmouse serio1: synaptics: Trying to set up SMBus access
>> psmouse serio1: synaptics: SMbus companion is not ready yet
>>
>> With this patch applied, i.e., the PNP IDs are added to the forcepad
>> array, the touchpad continues to work and all of the above messages
>> disappear.
> 
> Are you sure the touchpad in XPSes is a forcepad (i.e. it does not have
> physical button underneath it)? As far as I know there were only couple
> of HP laptops with forcepads and when switching to RMI mode forcepads
> need F21 handler that we do not currently have in the kernel.

I see, no, I'm not sure, but assuming you're right, the IDs 
should be added to the smbus array instead, after fixing 
the SMbus "companion not ready" problem?  Pointers for that and 
the below interrupts when touchpad idle after resume, welcome.

Also, the link to get the RMI4 spec in
Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt
is broken.  Any pointers for that also appreciated.

>> ---
>> With or without this patch, I'm seeing a problem where when the XPS 15
>> comes out of a resume, and without even touching the touchpad, I notice
>> about 600 interrupts per second firing on the "IR-IO-APIC   51-fasteoi
>> SYNA2393:00" line in /proc/interrupts.  If I start using the touchpad,
>> then leave it alone, I check if there are still interrupts firing, and
>> they have indeed stopped.  This adversely affects my battery life when
>> using an external mouse.  Any ideas on how to debug the situation?
>> Could it be related to the 'vdd not found' messages?:
>>
>> $ dmesg | grep -C 1 -i syna
>> probe of 1-12 returned 1 after 2343 usecs
>> psmouse serio1: synaptics: queried max coordinates: x [..5664], y [..4646]
>> psmouse serio1: synaptics: queried min coordinates: x [1278..], y [1206..]
>> psmouse serio1: synaptics: Touchpad model: 1, fw: 8.2, id: 0x1e2b1, caps: 0xf00123/0x840300/0x12e800/0x0, board id: 3125, fw id: 2378871
>> input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio1/input/input6
>> probe of serio1 returned 1 after 939332 usecs
>> --
>> probe of idma64.1 returned 1 after 72 usecs
>> i2c_hid i2c-SYNA2393:00: i2c-SYNA2393:00 supply vdd not found, using dummy regulator
>> i2c_hid i2c-SYNA2393:00: Linked as a consumer to regulator.0
>> i2c_hid i2c-SYNA2393:00: i2c-SYNA2393:00 supply vddl not found, using dummy regulator
>> ath10k_pci 0000:3b:00.0: qca6174 hw3.2 target 0x05030000 chip_id 0x00340aff sub 1a56:1535
>> --
>> ath10k_pci 0000:3b:00.0: firmware ver WLAN.RM.4.4.1-00079-QCARMSWPZ-1 api 6 features wowlan,ignore-otp crc32 fd869beb
>> probe of i2c-SYNA2393:00 returned 1 after 23978 usecs
>> ath10k_pci 0000:3b:00.0: board_file api 2 bmi_id N/A crc32 20d869c3
>> --
>> probe of 0018:056A:488F.0001 returned 1 after 1366 usecs
>> input: SYNA2393:00 06CB:7A13 Mouse as /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-10/i2c-SYNA2393:00/0018:06CB:7A13.0002/input/input23
>> input: SYNA2393:00 06CB:7A13 Touchpad as /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-10/i2c-SYNA2393:00/0018:06CB:7A13.0002/input/input24
>> hid-generic 0018:06CB:7A13.0002: input,hidraw1: I2C HID v1.00 Mouse [SYNA2393:00 06CB:7A13] on i2c-SYNA2393:00
>> probe of 0018:06CB:7A13.0002 returned 1 after 320 usecs
>> --
>> probe of 0018:06CB:7A13.0002 returned 0 after 5 usecs
>> input: SYNA2393:00 06CB:7A13 Touchpad as /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-10/i2c-SYNA2393:00/0018:06CB:7A13.0002/input/input27
>> hid-multitouch 0018:06CB:7A13.0002: input,hidraw1: I2C HID v1.00 Mouse [SYNA2393:00 06CB:7A13] on i2c-SYNA2393:00
>> probe of 0018:06CB:7A13.0002 returned 1 after 25104 usecs

Thanks,

Kim
