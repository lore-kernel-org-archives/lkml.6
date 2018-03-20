Return-Path: <heikki.krogerus@linux.intel.com>
X-Google-Smtp-Source: AG47ELvbKLNl2y1IvK5DTZ8MQSlcPr/Evlac6+U5DluUajqEdTM1iANolyhI3e/NRFBlGRQHGDDu
ARC-Seal: i=1; a=rsa-sha256; t=1521550366; cv=none;
        d=google.com; s=arc-20160816;
        b=qW7UHPQ4qk2vDaocI4I31aM2m1M06F3ZEJ2vUb8bazEF9TP+GOprnzS9s5INbH7bLR
         wRwGY6w1dWnXER8vvl9GivP6vZIH15foex1O76bT4EjzX0kY7L4k2qZr+SMCxFURILu8
         aCrEhRwALuIUqomzpQBcPUY68blkqNtJcDWYUeuPcSVF4YOkxTlE6WqmFvpFMopmb3qb
         ppCtVFkwa2A3U3h20u+JxNHsRv5LaLWW3HjagqJ9UtSxj+ieHKMZVcy+eTYkWwD43mQt
         EmENpOFWfcy7WgiR8ImbrZ9DS/AvdAnIFZ5cDluOIGhm5r4fcjbQUXH/Bt8QbLwk75NO
         VAyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=n1ufFpB27n0EfYyddytwXRJ8h1jyGPsS3IaMChGrgU4=;
        b=a9SGh/xpyOrmk8LQ/FIAuEe+TANCdtTvN4Ip525yKGdBMIMP6/VTdQgEhn1wH2OiN0
         tm2VPS3maaV+XKqeR8M/6cE9Pr9thAgBxCWViXPaYLstYbORQDHEh7GaDpuY3D3uIsXP
         CLR5v9ZeZMNsIGimaxCh30ORxqJvwdC+Nnt3mOQVkvPu2/xYcYPCbC+c83MxlEXvlM9p
         LmhRhjHp5ILt/RBiBVbidNFuq/Or5vy0pympP2H6klP+nS7JVNEMqluFnpUDSSuUBjYW
         ScQ+BDjhiY+5tfK98VDVUCNEzdK6yiF6kpk1WVVxDDEbMj1v8qmQLRePMYJywokk13Bb
         LYng==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,335,1517904000";
   d="scan'208";a="39591493"
Date: Tue, 20 Mar 2018 14:52:40 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Darren Hart <dvhart@infradead.org>,
	Andy Shevchenko <andy@infradead.org>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Guenter Roeck <linux@roeck-us.net>, Jun Li <jun.li@nxp.com>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH v8 01/12] drivers: base: Unified device connection lookup
Message-ID: <20180320125240.GA25137@kuha.fi.intel.com>
References: <20180314131215.70833-1-heikki.krogerus@linux.intel.com>
 <20180314131215.70833-2-heikki.krogerus@linux.intel.com>
 <20180320092004.GA21081@kroah.com>
 <20180320100412.GI11689@kuha.fi.intel.com>
 <20180320103259.GJ11689@kuha.fi.intel.com>
 <eb9950fe-54fd-eda8-e678-f2216204f62f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb9950fe-54fd-eda8-e678-f2216204f62f@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593820906030657716?=
X-GMAIL-MSGID: =?utf-8?q?1595461196989952427?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 20, 2018 at 01:21:57PM +0100, Hans de Goede wrote:
> On 20-03-18 11:32, Heikki Krogerus wrote:
> > On Tue, Mar 20, 2018 at 12:04:12PM +0200, Heikki Krogerus wrote:
> > > > > +void device_connection_remove(struct device_connection *con)
> > > > > +{
> > > > > +	mutex_lock(&devcon_lock);
> > > > > +	list_del_rcu(&con->list);
> > > > 
> > > > See, rcu?
> > > 
> > > True. I'll send one more version.
> > 
> > Before I do that, Hans, can you quickly check this and see that I
> > have not made any more mistakes? I don't trust myself anymore with
> > these.
> 
> This looks good to me (note I did not test only reviewed).

Thanks. I'll send v9.

Br,

-- 
heikki
