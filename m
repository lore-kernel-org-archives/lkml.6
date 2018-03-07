Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754359AbeCGMtm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 07:49:42 -0500
Received: from mga02.intel.com ([134.134.136.20]:26123 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753953AbeCGMti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 07:49:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,435,1515484800";
   d="scan'208";a="36192650"
Message-ID: <1520426974.10722.449.camel@linux.intel.com>
Subject: Re: [PATCH v6] mmc: Export host capabilities to debugfs.
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Harish Jenny K N <harish_kandiga@mentor.com>,
        Avri Altman <Avri.Altman@wdc.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Vladimir_Zapolskiy@mentor.com" <Vladimir_Zapolskiy@mentor.com>
Date: Wed, 07 Mar 2018 14:49:34 +0200
In-Reply-To: <af726c5a-edd4-94f9-7789-4527e9aff93d@mentor.com>
References: <1520401051-11135-1-git-send-email-harish_kandiga@mentor.com>
         <DM5PR04MB10857D9F0177C760047100D1FCD80@DM5PR04MB1085.namprd04.prod.outlook.com>
         <af726c5a-edd4-94f9-7789-4527e9aff93d@mentor.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-03-07 at 12:34 +0530, Harish Jenny K N wrote:

> > > > > > 
> > > +static int mmc_caps_show(struct seq_file *s, void *unused) {
> > > +	struct mmc_host *host = s->private;
> > > +	u32 caps = host->caps;
> > > +
> > > > > > +	seq_puts(s, "\nMMC Host capabilities are:\n");

First of all, avoid leading '\n' in the messages.

> > > > > > +	seq_puts(s,
> > > 
"=============================================\n");
> > > +	seq_printf(s, "Can the host do 4 bit transfers :\t%s\n",
> > > +		   ((caps & MMC_CAP_4_BIT_DATA) ? "Yes" : "No"));
> > 
> > Maybe use a more compact form, and just call a macro with the
> > applicable (stringified) bit?
> 
> Something like this ?
> 
> #define YN(bit) ((caps & bit) ? "Yes" : "No")
> and then call
> seq_printf(s, "Can the host do 4 bit transfers :\t%s\n",
> YN(MMC_CAP_4_BIT_DATA));
> 

I would rather say something like this:

static const char * const mmc_host_capabilities[] = {
 "4-bit transfers allowed",
 "...",
 ...
};

...
  for_each_set_bit(i, caps)
   seq_printf("%s\n", mmc_host_capabilities[i]);
...


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
