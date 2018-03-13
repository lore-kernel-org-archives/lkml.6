Return-Path: <kernel-hardening-return-12521-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtDmXnK3FVBlDCqc04i9fIZt4OaqSU4yU+RCRXa95yx3L4NXYKxqdWF6GvVsok4X+P72pMk
ARC-Seal: i=1; a=rsa-sha256; t=1520971849; cv=none;
        d=google.com; s=arc-20160816;
        b=yuWOUBC2dDZ95XZyZWxNtIxyQlKFuhoMwTrWukWtR45UFlW5J4Mey9P6IL39euJFba
         RdxB116487/wb/BLcwKGNU9U+NP6kQfYsxQ/iq1HF/t/SwwTpcNRxMwjxT/Vc3eqfnSz
         eY+fzEvq48rj/llWfWyGZJTyE4VMS6vU+qFfO24LuiRokHEONfQeQdJdfdAlK0ISMtrc
         7GqY14VUcrc3c28BZqjkZXoWQ+UkFQBYtrh3Vkyv2GIw6sw817BGeY35o8q2cH9amdy8
         m8kReS7OIm3k2PjrmUJmHkmCd2PiktnRyF3O8xqWY3xeuXrbQvV7ka8/z6+sdFZIVRuQ
         FGfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:delivered-to:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=6jVRncZ3RJv8kqRX2W77wx+aLKbCQYSwrTsBGl5uTYg=;
        b=OlhlQ52Lzo8YLUBB0pYdeqOquE/ficqLwiG4f4u4q/PuPCVx3Sbjea5SjqXLxGOhQE
         ma2UV1KRc0aGPRVlLf6qFzNNMtvywUOyDU9eqmGxWq6GJ+lesRweq/k5nZerZSnIaLhu
         3OgKl8d7pvkHA3eSuz28gz36hQjUzKjNqaePfRuHWiz0qPh9WzIBZDlc/tKSZ209H68V
         TgeneFwh1Q3f/aXlH7IsQjAYRD6LGMatb7dbPw+uuw7rB0401T7A0K7GnWGJEnBXKuE/
         o4xqf/IjQEl5Z+7Kms7qRifoyaUJJyVsCMj4i6nhnUwQHCPgiWhnaKgdRYwkugJ6Wxha
         p/Iw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=uZ+ufC2o;
       spf=pass (google.com: domain of kernel-hardening-return-12521-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12521-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=uZ+ufC2o;
       spf=pass (google.com: domain of kernel-hardening-return-12521-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12521-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH] net: dsa: drop some VLAs in switch.c
To: Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
 Salvatore Mesoraca <s.mesoraca16@gmail.com>, linux-kernel@vger.kernel.org
Cc: kernel-hardening@lists.openwall.com, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
 Kees Cook <keescook@chromium.org>
References: <1520970647-19587-1-git-send-email-s.mesoraca16@gmail.com>
 <87fu5321du.fsf@weeman.i-did-not-set--mail-host-address--so-tickle-me>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <b948ef55-8b16-fee4-b22f-4c6d09fea0cf@gmail.com>
Date: Tue, 13 Mar 2018 13:06:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87fu5321du.fsf@weeman.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594853343808183482?=
X-GMAIL-MSGID: =?utf-8?q?1594854577825810314?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/13/2018 12:58 PM, Vivien Didelot wrote:
> Hi Salvatore,
> 
> Salvatore Mesoraca <s.mesoraca16@gmail.com> writes:
> 
>> dsa_switch's num_ports is currently fixed to DSA_MAX_PORTS. So we avoid
>> 2 VLAs[1] by using DSA_MAX_PORTS instead of ds->num_ports.
>>
>> [1] https://lkml.org/lkml/2018/3/7/621
>>
>> Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>
> 
> NAK.
> 
> We are in the process to remove hardcoded limits such as DSA_MAX_PORTS
> and DSA_MAX_SWITCHES, so we have to stick with ds->num_ports.

Then this means that we need to allocate a bitmap from the heap, which
sounds a bit superfluous and could theoretically fail... not sure which
way is better, but bumping the size to DSA_MAX_PORTS definitively does
help people working on enabling -Wvla.
-- 
Florian
