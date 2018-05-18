Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752226AbeERKVF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 06:21:05 -0400
Received: from mga17.intel.com ([192.55.52.151]:22792 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751581AbeERKVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 06:21:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,414,1520924400";
   d="scan'208";a="229718350"
Message-ID: <cabb42db7aec59f0b795a16809b0ccfaeddb2679.camel@linux.intel.com>
Subject: Re: [BUG] i2c-hid: ELAN Touchpad does not work on ASUS X580GD
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Chris Chiu <chiu@endlessm.com>
Cc: Daniel Drake <drake@endlessm.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Adrian Salido <salidoa@google.com>,
        Jason Gerecke <killertofu@gmail.com>,
        linux-input <linux-input@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Date: Fri, 18 May 2018 13:20:58 +0300
In-Reply-To: <822d5f47cad46ca308d511f7f24cdbc5f4af38b9.camel@linux.intel.com>
References: <CAPpJ_ed-JPOzQPtyCdH4_C7dzEeM3fznus8XDuaojaiM_4nFpw@mail.gmail.com>
         <CAB4CAwcKu88xP0R9P-3csd6SE2fZ-Vb6OrQD9AmBDh6p77VFDQ@mail.gmail.com>
         <a9e1f1cb-b823-8690-930f-f7346798341a@linux.intel.com>
         <CAD8Lp46b+-B=xqSAqB+zV4xF6SRUGs46FkydS37UEuqav_jNog@mail.gmail.com>
         <CAB4CAwd0tN7CaS7YZCo3TZH-DPxt0x6wxyO23v7aBW9MOCtHCw@mail.gmail.com>
         <c1343704-6b1a-14b5-3942-a8a33f73feee@linux.intel.com>
         <CAB4CAwe6kjJ10s0KtVJrPMSC8UA+YLCiqbnkZ_-oFTKTFPTwCw@mail.gmail.com>
         <7728da79-8a7a-b87d-d09c-b36978b3032e@linux.intel.com>
         <a3ce1af5-7b99-38db-fc51-4d580db1e87e@linux.intel.com>
         <ba99be8e-8e8b-87c1-8607-24ace8a01c64@redhat.com>
         <822d5f47cad46ca308d511f7f24cdbc5f4af38b9.camel@linux.intel.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-05-18 at 11:37 +0300, Andy Shevchenko wrote:
> On Fri, 2018-05-18 at 09:48 +0200, Hans de Goede wrote:
> 
> 
> > Could it be the i2c input clock definition in drivers/mfd/intel-
> > lpss-
> > pci.c
> > is also wrong for Apollo Lake (N3450) ?  There are lots of people
> > having
> > various issues with i2c attached touchpads on Apollo Lake devices,
> > this bug:
> > https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1728244
> > 
> > Is sort of a collection bug for these. Various models laptops, lots
> > of
> > reporters. Note not sure thie is an i2c-designware issue, but it
> > would
> > be good to double check the input clock on Apollo Lake.
> > 
> > I've checked the datasheet and the datasheet mentions 133MHz as
> > "serial input clk" in the lpio_bxt_regs Registers Summary, which is
> > also part of the LPSS, no clk is mentioned in the "Summary of
> > DW_apb_i2c_mem_map_DW_apb_i2c_addr_block1 Registers".
> 
> The internal datasheet we have access to mentioned in this case for
> Broxton and Cannonlake together. So, your assumption might be quite
> close to the truth and the issue is inherited from Broxton.
> 

Hans, can your reporters try the following patch? Depending on the
result I may send it out ASAP.

--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -120,7 +120,7 @@ static struct property_entry apl_i2c_properties[] =
{
 };
 
 static const struct intel_lpss_platform_info apl_i2c_info = {
-       .clk_rate = 133000000,
+       .clk_rate = 216000000,
        .properties = apl_i2c_properties,
 };

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
