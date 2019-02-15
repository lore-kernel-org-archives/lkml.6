Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD61FC10F06
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 884C921B18
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387726AbfBOPG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 10:06:26 -0500
Received: from mga12.intel.com ([192.55.52.136]:35595 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbfBOPGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 10:06:25 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Feb 2019 07:06:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,373,1544515200"; 
   d="scan'208";a="122709597"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga007.fm.intel.com with ESMTP; 15 Feb 2019 07:06:21 -0800
Received: from andy by smile with local (Exim 4.92-RC6)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1guf4G-0000Tr-21; Fri, 15 Feb 2019 17:06:20 +0200
Date:   Fri, 15 Feb 2019 17:06:20 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     xiang xiao <xiaoxiang781216@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        alexander.shishkin@linux.intel.com,
        Ohad Ben Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        wendy.liang@xilinx.com, Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        Kumar Gala <kumar.gala@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guiding Li <liguiding@pinecone.net>
Subject: Re: [PATCH V2 2/2] rpmsg: add syslog redirection driver
Message-ID: <20190215150620.GB9224@smile.fi.intel.com>
References: <1550124158-1111-1-git-send-email-xiaoxiang@xiaomi.com>
 <1550124158-1111-2-git-send-email-xiaoxiang@xiaomi.com>
 <20190214130940.GV9224@smile.fi.intel.com>
 <CAH2Cfb8UYMLpxb5DDPxf_C0umgPgLK8FBedhcNUcYQ_gLs2dFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2Cfb8UYMLpxb5DDPxf_C0umgPgLK8FBedhcNUcYQ_gLs2dFw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 12:31:17AM +0800, xiang xiao wrote:
> On Thu, Feb 14, 2019 at 9:09 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Feb 14, 2019 at 02:02:38PM +0800, Xiang Xiao wrote:

> > > This driver allows the remote processor to redirect the output of
> > > syslog or printf into the kernel log, which is very useful to see
> > > what happen in the remote side.
> >
> > > +struct rpmsg_syslog_header {
> > > +     u32                             command;
> > > +     s32                             result;
> > > +} __packed;
> >
> > Isn't packed already?
> >
> 
> But, I want to make it more explicitly and prepare for struct expansion later.

How? Why it's not in this patch / patch series?

> > > +     /* output the message before '\n' to the kernel log */
> > > +     nl = memrchr(msg->data, '\n', msg->count);
> >
> > Hmm... To me it sounds somehow fragile.
> >
> > If your text contains binary data, how can you guarantee that it would be not
> > in the middle of two \n:s?
> 
> This driver is just for log/printf redirection, so we could safely
> assume the data is pure text.

Then I don't see a point to use memrchr() at all here.

Use strchr or strrchr().

> > OTOH, if it text data, why do you need to take all strings at once?
> 
> Remote side may decide to buffer more log to reduce the IPC number
> since IPC is a time consuming operation.

So, you always can do something like

p = msg->data;
while (...strsep(..., "\n")) {
	pr_info("%s\n", token);
	...
}

> 
> >  It might be worse from performance prospective (if you know how and when printk() supplies buffer to the console).
> 
> Yes, it's very slow if the log send to serial console. But in
> production environment, printk normally just save in ram and viewed by
> dmesg which is very fast.

You may not do such assumptions. For someone it would be RAM, for some
customers it might be a slow channel.


> > > +             strncpy(priv->buf + priv->next, msg->data + printed, copied);
> >
> > Hmm... shouldn't be memcpy()?
> 
> I use memcpy initially, but found that the unaligned exception happen randomly.
> To avoid the cache issue, the IPC memory normally map as device memory, but
> ARM just allow the alignment access to this type of memory.

So, than it's an architecture level issue. With strncpy() here you will get a
pretty rightful GCC warning.

> > > +     /* flush the buffered log if need */
> > > +     if (priv->next)
> > > +             pr_info("%.*s\n", priv->next, priv->buf);
> > > +     kfree(priv->buf);
> >
> > I don't see how it's serialized. Does rpmsg core take care of this?
> 
> Yes, the callback come from a dedicated work thread.

Please, add a comment explaining that.

-- 
With Best Regards,
Andy Shevchenko


