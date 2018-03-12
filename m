Return-Path: <kernel-hardening-return-12468-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELuweeMD6AcIBfLKnENDIcXISqgz8JwEDJxopOAy+rLMwnB3rHliuAYV+o1aibzUsZSw+JKa
ARC-Seal: i=1; a=rsa-sha256; t=1520873301; cv=none;
        d=google.com; s=arc-20160816;
        b=H8k2Z4VChk8yTfSlJzYswyIUsGFmJe0ytNdDpujvmCjpseg98D2oFJs3GeR5AseTFj
         lkxgJ0dlw+CWViepQFCCzunenaisrARNLzTrkF6pKZkac4cKEnLq0HBdYREiLROAAqi6
         YwpLx9uoiuL/I1fEO4YaZojoT6fE3jSOigmaNdiUQKjA6lMkLdwKDBPBcaHtDUfBSE2e
         QRAyz2CvFh67uT01jNJ12X5Etan6h6eteusBlHx5WoxYDWKdPri71Pf8ADG1SkylegjU
         LlVrjKU5pgxyAR1em37YOsthaqJ1qORrHiHjahYd+FQPM5ZW5QwQ6TA/VXYGEI6I3L2Y
         Wmuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=l4p7bEM2VSNy0x85u0XmTE0AlyYZMetSh3xL+YVL3M0=;
        b=zsTBEz4yYgm8RnXb0njgaquQDvN15fFAnvCAJWSemOcxRFaKgeLEQnXnJVJPJ2rPC8
         5JpEU0xe7vE66HlhkXlfn3hmjXSgrxdlHAECrZmaEc8+gGfEOyGxnz3bXV7Wai/JFlMk
         +7VApCl9fDmTgnie74nR/SWEIiiFNpJ+df9FwOlCUDIdJzAS8a3UAaIcmP9G4kh9H3NP
         okgGAylZEA6c/YUslYVWOUJFzrztiX7yC+Pf0semafGhLsyhWJiCtiOoc8/Xd3vbqLzg
         HxbjFF2cP+NvKn+P0465Vmi8uoTpMEtO+7ufeTDcHb/gU56kerZNK4omZoYzRnBAXTsO
         NW+g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=RnsP55Am;
       spf=pass (google.com: domain of kernel-hardening-return-12468-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12468-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=RnsP55Am;
       spf=pass (google.com: domain of kernel-hardening-return-12468-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12468-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <20180312.111432.849792523664957837.davem@davemloft.net>
References: <1520802724-17509-1-git-send-email-s.mesoraca16@gmail.com> <20180312.111432.849792523664957837.davem@davemloft.net>
From: Salvatore Mesoraca <s.mesoraca16@gmail.com>
Date: Mon, 12 Mar 2018 17:47:41 +0100
Message-ID: <CAJHCu1Li=FWwxW2GdZGvm7RYbzkC5=dZRTu9tNukAMWMGwOCcw@mail.gmail.com>
Subject: Re: [PATCH] net: llc: drop VLA in llc_sap_mcast()
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, netdev@vger.kernel.org,
	paulmck@linux.vnet.ibm.com, rientjes@google.com, elena.reshetova@intel.com,
	ishkamiel@gmail.com, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594677285477224056?=
X-GMAIL-MSGID: =?utf-8?q?1594751242697287242?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-03-12 16:14 GMT+01:00 David Miller <davem@davemloft.net>:
> From: Salvatore Mesoraca <s.mesoraca16@gmail.com>
> Date: Sun, 11 Mar 2018 22:12:04 +0100
>
>> Avoid a VLA[1] by using a real constant expression instead of a variable.
>> The compiler should be able to optimize the original code and avoid using
>> an actual VLA. Anyway this change is useful because it will avoid a false
>> positive with -Wvla, it might also help the compiler generating better
>> code.
>>
>> [1] https://lkml.org/lkml/2018/3/7/621
>>
>> Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>
>
> Applied.

Thank you.
