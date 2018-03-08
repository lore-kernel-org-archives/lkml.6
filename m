Return-Path: <kernel-hardening-return-12243-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELuBDiz8ncNZoTW7TXBKv4G7agQba24tdxJ1Oq8WdPqeVvKonlPHfg6mwxDODqj5fktjUt0t
ARC-Seal: i=1; a=rsa-sha256; t=1520531854; cv=none;
        d=google.com; s=arc-20160816;
        b=qYG6Iv1ZIx6gmizV2+EFC2HBuoV4dXN63+PailqeCLaeSvf7tf/sjUg3s2NFi4RvWo
         DYuoDlJrNeMJmBTw8bOYtsOvV8r4amFnuhGlC6R/Bods/32/Xq7bBB0aiAphddbEcYml
         KFpZGIq+OGeYhnj4Z6/yiKf617C9hHBRf7aW55vQMFl/1UmCIgFegvCAWkGX04kfpCfB
         p3OWDwxsXUazB14PiirheweS1VQ8MggI6uQyatPZgQGAqAhKFS5SiJVBeT0GPBuG5vvt
         7AeoRpPZ72PSdlQ+HIX67L88qi0tKB83/jizNw9PHI0UFyyok0mfzgUHxaDytZFV3TEe
         IGwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:delivered-to:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=ly1YBzrWhJ0RPMvbE4PZxmRFHnUxaf/sAYeStq7B0+8=;
        b=dccrwi8eIfwaVaqzmMVPf5qjWxUwIq04cnYLAiHxAd8mY6Bf5DgxLYXoL+zoyhmMf2
         mHCY+mMbVTtbx+WnaQyfZ2iMh6VFVdO+fkKwfdaP5Ru0ua2LvJC3+GfktbE6FB2kUoh5
         eQW60I8HgMqKIAuEUR6PXF9vdjI0uzPQKGaUhSj5KG39VkP3ZQJD60hDFwW+W2kK51Bs
         25N6smuQBoU7qnD4vKKgTIlvmEEBs8s8Q7IeSCBnLkLrgKzfkgeN0yLUHmyFkb0Wt/Pt
         m0Jn5ZJ8eYcicnYJvKJGild/bnddoJUVKXFu7lbDmcXbmKZImO3QZdmlXGdKfNeT7PNT
         JEkg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=pFcRoKpj;
       spf=pass (google.com: domain of kernel-hardening-return-12243-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12243-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=pFcRoKpj;
       spf=pass (google.com: domain of kernel-hardening-return-12243-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12243-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <20180308171456.2597-1-tycho@tycho.ws>
References: <20180308171456.2597-1-tycho@tycho.ws>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 8 Mar 2018 19:47:37 +0200
Message-ID: <CAHp75VfoiQ_PxBph8JnNzun4y5Z-9z_rUcjGyM7A2CAwynddeA@mail.gmail.com>
Subject: Re: [PATCH] ima: drop vla in ima_audit_measurement()
To: Tycho Andersen <tycho@tycho.ws>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	linux-integrity@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kernel-hardening@lists.openwall.com
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594389722092015419?=
X-GMAIL-MSGID: =?utf-8?q?1594393209975613360?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 8, 2018 at 7:14 PM, Tycho Andersen <tycho@tycho.ws> wrote:
> In keeping with the directive to get rid of VLAs [1], let's drop the VLA
> from ima_audit_measurement(). We need to adjust the return type of
> ima_audit_measurement, because now this function can fail if an allocation
> fails.



> +       algo_hash_len = hash_len + strlen(algo_name) + 2;
> +       algo_hash = kzalloc(algo_hash_len, GFP_KERNEL);

> -       snprintf(algo_hash, sizeof(algo_hash), "%s:%s", algo_name, hash);
> +       snprintf(algo_hash, algo_hash_len, "%s:%s", algo_name, hash);

kasprintf() ?

-- 
With Best Regards,
Andy Shevchenko
