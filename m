Return-Path: <kernel-hardening-return-12249-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvXZJ7PoxCR3wGuaH5XQViEPSnMt2TcqlP83cQcuVVV4d4eCTNkuXNe7+TnmkDRw3yLmTGq
ARC-Seal: i=1; a=rsa-sha256; t=1520534262; cv=none;
        d=google.com; s=arc-20160816;
        b=Y07S2viHjllb6nysY8LV4IZ4aX/nRnYsIL/c92Ab0ckQXJScQSRuwtxqJo6aNWPYCN
         jYqyDb6N2mLKkighH2g0eOgGVdPQopjROVD8QP/2Lj+a7cN72dHipcM1oEnvI32wOr0L
         kgVwbPI2b/fL0OwnCc7fe031c/xZ2kai9SJcGq9PWERK9uRHOoGRxUGkw4iEJ22SJGup
         H+wPDdOJtPYCNU04hfobROAQzjDAkT1E0UIDRSxLYsy7awhLy5+yUTICEm1ho8DuwfeZ
         j0mwE8RzCUXLoR/PyP2jq6P6vFQfTHvcHY4/66t95dypJUFjwsBIf7QlkNr4UHuP+iEW
         uOXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=NyZvGO/iPlvYeBDJCStSo4X4CCELugZvzFy7moEVzko=;
        b=HITgjTyvUM/pEOlND2SEiCI6syNbpK1M1je5D5z0njsFjqg6RkIVvjnpM/Q3luD7Sd
         +Uy/QG8U3nNua2cY7kcAshz/2uenTbxhJrhc5iFVo5BKvXnmcSGzWIYQSr/4jFcPAtlH
         MOeer46waIJVRut8Ov4t36kVn49vYYec1EF1UdHQpM3fwwdjLDco8+D3yQvCdsorR7Z5
         bJJxHqjlqS+YZpWGXh7f573xaWJHlixH6htPKn4d68mKTEzlE20mS2gBy6GgXtYdwyYT
         aS9ApLLVN94ZiHCzIsDHrdnr4m6W/gvybWhtCOBhfNlrtrsn949mXTw9oWj5dneoD7e9
         09Nw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tycho-ws.20150623.gappssmtp.com header.s=20150623 header.b=On0gUOl1;
       spf=pass (google.com: domain of kernel-hardening-return-12249-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12249-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tycho-ws.20150623.gappssmtp.com header.s=20150623 header.b=On0gUOl1;
       spf=pass (google.com: domain of kernel-hardening-return-12249-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12249-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Thu, 8 Mar 2018 11:37:21 -0700
From: Tycho Andersen <tycho@tycho.ws>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	linux-integrity@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	kernel-hardening@lists.openwall.com
Subject: Re: [PATCH] ima: drop vla in ima_audit_measurement()
Message-ID: <20180308183721.mnsrmhekyfo2dbso@smitten>
References: <20180308171456.2597-1-tycho@tycho.ws>
 <CAHp75VfoiQ_PxBph8JnNzun4y5Z-9z_rUcjGyM7A2CAwynddeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VfoiQ_PxBph8JnNzun4y5Z-9z_rUcjGyM7A2CAwynddeA@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594389722092015419?=
X-GMAIL-MSGID: =?utf-8?q?1594395734728425933?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 08, 2018 at 07:47:37PM +0200, Andy Shevchenko wrote:
> On Thu, Mar 8, 2018 at 7:14 PM, Tycho Andersen <tycho@tycho.ws> wrote:
> > In keeping with the directive to get rid of VLAs [1], let's drop the VLA
> > from ima_audit_measurement(). We need to adjust the return type of
> > ima_audit_measurement, because now this function can fail if an allocation
> > fails.
> 
> 
> 
> > +       algo_hash_len = hash_len + strlen(algo_name) + 2;
> > +       algo_hash = kzalloc(algo_hash_len, GFP_KERNEL);
> 
> > -       snprintf(algo_hash, sizeof(algo_hash), "%s:%s", algo_name, hash);
> > +       snprintf(algo_hash, algo_hash_len, "%s:%s", algo_name, hash);
> 
> kasprintf() ?

Sure, in fact I think we could just do:

-	snprintf(algo_hash, algo_hash_len, "%s:%s", algo_name, hash);
-	audit_log_untrustedstring(ab, algo_hash);
+	audit_log_untrustedstring(ab, algo_name);
+	audit_log_format(ab, ":");
+	audit_log_untrustedstring(ab, hash);

and get rid of the allocation entirely. I'll test and make sure it
works and then re-send.

Cheers,

Tycho
