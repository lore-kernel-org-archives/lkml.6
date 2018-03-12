Return-Path: <okaya@codeaurora.org>
X-Google-Smtp-Source: AG47ELvDDYcRWMxFNnLthIBhe6Vp1gbsCg5vaAlubcev1MoMCKhFaG6oNfLTRvH6jCcrXUflXDXA
ARC-Seal: i=1; a=rsa-sha256; t=1520823843; cv=none;
        d=google.com; s=arc-20160816;
        b=VHoHGf6Igg/T4nqwWJ60XvsTYWQp4FTokjDgXeZ07MkKwoXxdM7aJXPBt+l+nOlLbT
         79Rb4EEMndd8VJqLx/0xpEiy8T/3XHM2AST6GhbbohKkk783eutdTVnI2lx2cYilM/nt
         Jqc3fgdEHO/y9o8FUPpx4IKm+ozmz06cRMBLiiENpXCdKqabn8/Ws0f4fkjmsn0Us1WN
         jvWLwbuzazhSYIWKFW5/V/c4TNnF0OMdHK3WIZ2WoBbeTLm/203nA9tZVL+poEimEbEi
         MzYmxxjVuNgj7sYb4hBjZtQw0jetPYKuAPgAEL0NAgdNlfFmLRY1r2f8PuuydGh4PWEb
         Ti2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=+qgegphngNO3u1XSthUKbUZD8ps77xcmFQKGGcBJOk0=;
        b=maq3ZOuybGxMF92z5nQ1UDyMOsqkg19HyNy9ET7U127PKZbJ1Y9eosZXD1L939Fc0X
         1brWDcVqPZ1+QlgwSBJ6cAKU3q9Izn25ZDTG63TqyKZTbm60ccTY28ACwlGBOLGilRls
         UeV8FZOpGUt+1em4ftgwlQYPiopDmw3arQfWP5bVvFxtGudNYp5HlacWiUa1yT66plAW
         nF7HwiVZRMKR4jE83cW7R0jq5iF3mp/GpVAPCPSqTLNCd5XeUskzIFMkvyoilKVpv672
         q8iVH8wCCgvhPeHJXq/jEsVXq66r2hxoQTIrkBKuRFZUblwkPvjdyQGYadEcqavBxL8d
         kzVw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=RbKesiNC;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Jw5qVVY5;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=RbKesiNC;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Jw5qVVY5;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5744D60390
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH v12 0/6] Address error and recovery for AER and DPC
To: Bjorn Helgaas <helgaas@kernel.org>, Oza Pawandeep <poza@codeaurora.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kate Stewart <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>,
 Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
 Timur Tabi <timur@codeaurora.org>
References: <1519837457-3596-1-git-send-email-poza@codeaurora.org>
 <20180311220337.GA194000@bhelgaas-glaptop.roam.corp.google.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <04ade52e-d1ea-fe67-bb26-246621d159e6@codeaurora.org>
Date: Sun, 11 Mar 2018 23:03:58 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180311220337.GA194000@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593665102741565714?=
X-GMAIL-MSGID: =?utf-8?q?1594699382236701958?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 3/11/2018 6:03 PM, Bjorn Helgaas wrote:
> On Wed, Feb 28, 2018 at 10:34:11PM +0530, Oza Pawandeep wrote:

> That difference has been there since the beginning of DPC, so it has
> nothing to do with *this* series EXCEPT for the fact that it really
> complicates the logic you're adding to reset_link() and
> broadcast_error_message().
> 
> We ought to be able to simplify that somehow because the only real
> difference between AER and DPC should be that DPC automatically
> disables the link and AER does it in software.

I agree this should be possible. Code execution path should be almost
identical to fatal error case.

Is there any reason why you went to stop driver path, Keith?

Was it the absence of error callback? or are we missing something in our
assumptions?

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
