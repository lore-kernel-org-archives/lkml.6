Return-Path: <heikki.krogerus@linux.intel.com>
X-Google-Smtp-Source: AH8x227XTCviK560iNVtEZrRvptpZiRPNQhjkjXp8lDKrtV6KFUEEqV+qErs8rZOHgexScnYXVfI
ARC-Seal: i=1; a=rsa-sha256; t=1518780509; cv=none;
        d=google.com; s=arc-20160816;
        b=fFjuDefWpO0FkJoqC6jT2Ar/gh5ves+jZ/4Tt3z/nsaz8UqaFSfPR57bZlIBwLIyr2
         LhV9lYoE1bTEHo0xIpFDb6z0yFlbO34UOgMemCdaNfX6KZhITlvAEOiZ5Dvc0jGZzS63
         Xi3Z343I9RLdktQrLPuSid8kofKydU2xzUbLlBuIKttkfB+y2iHenhbif5/TDPaRE9Uj
         WWCybDp2B+zP4zjCPA+oQHi5Phk+4ORZ7rZrbiG/NzelUNszp92ujzbJyyrD4lyZ3i8E
         YJX2Ftx159VhRLUkktetE8GyFlCe3u9ECFqotwjL4+EbDhndqaQp0c5wkjJY4o9K4wsp
         EbhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=u8v7XKLEovF1o0VEI5im+1EySN/cWhTzt/z87MHl3RA=;
        b=GaJfuQDAyiDk6p8Pj9TAs5RUE+TPISYNDjwORBh6JcNZr+dsvuoH6Rp/7BxHkh0bLW
         xPqzcfeqKyCYBi2CZR2yqOXReZCnj7ClVOMrhxCGbVyIbQidrYHTD3cwP2xQL2NjR3dD
         90nBtDRpg8s6DkcCCGk9kItXWqdtMpiRmGFReLZdA2wC3FhYshEAccX34ukZDPGJ5od9
         V+3s3a71FihDOqGtNsWHKYEo1Mdtks1Ph2xzjImp2VaENeVTtl4P6ldsLeGDAlhA4JvB
         I3nD9QYPc6EA1JNgwnkvL8Kj0EQ76lf6KJKMOayvhZ+Ab4lDeI9ym8WX8KBzBAP7Hw4D
         DXaQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,519,1511856000";
   d="scan'208";a="31344909"
Date: Fri, 16 Feb 2018 13:28:23 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Darren Hart <dvhart@infradead.org>,
	Andy Shevchenko <andy@infradead.org>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Platform Driver <platform-driver-x86@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	USB <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 01/12] drivers: base: Unified device connection lookup
Message-ID: <20180216112823.GI1480@kuha.fi.intel.com>
References: <20180216104751.8371-1-hdegoede@redhat.com>
 <20180216104751.8371-2-hdegoede@redhat.com>
 <CAHp75VcyrUvPzojY1J2cUheuYz6mRCP_VppSx740ELanNaQ+Hw@mail.gmail.com>
 <ee0d4723-ab1c-85d8-e6b7-a66e1a045b02@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee0d4723-ab1c-85d8-e6b7-a66e1a045b02@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592554240474198637?=
X-GMAIL-MSGID: =?utf-8?q?1592556791147856216?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 16, 2018 at 12:21:15PM +0100, Hans de Goede wrote:
> Hi,
> 
> On 16-02-18 12:00, Andy Shevchenko wrote:
> > On Fri, Feb 16, 2018 at 12:47 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> > > From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > 
> > > Several frameworks - clk, gpio, phy, pmw, etc. - maintain
> > > lookup tables for describing connections and provide custom
> > > API for handling them. This introduces a single generic
> > > lookup table and API for the connections.
> > > 
> > > The motivation for this commit is centralizing the
> > > connection lookup, but the goal is to ultimately extract the
> > > connection descriptions also from firmware by using the
> > > fwnode_graph_* functions and other mechanisms that are
> > > available.
> > 
> > > +void *__device_find_connection(struct device *dev, const char *con_id,
> > 
> > > +                              void *data,
> > > +                              void *(*match)(struct devcon *con, int ep,
> > > +                                             void *data))
> > 
> > Perhaps swap them, since data is dependent parameter to match.
> 
> The pattern of having the data before the callback function is not
> unheard of in the kernel. Changing this now feels like needless
> churn, but if there is a strong preference for this then we can
> fix this for v2.
> 
> Heikki, do you want me to take care of minor changes like this for v2?

Yes, please do if you don't mind. I would appreciate it.

I'll be on vacation next week.


Thanks,

-- 
heikki
