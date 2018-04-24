Return-Path: <kernel-hardening-return-13107-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AB8JxZqQrFS9mrWIe/Gv2ybLcxUVNFC2K9rVNnlCySLQLWhfnHXZOCuQMZHTdPTjT+GyrVbmZ357
ARC-Seal: i=1; a=rsa-sha256; t=1524573250; cv=none;
        d=google.com; s=arc-20160816;
        b=rkZMK9CDl1G765VnxD7pczfc45km3JiY1ZZa0IrL4EtTM6j7HjztRtBr3SXM19pHIu
         GhkM/W7g2qVQbQyIQmmYW14ftWd4Jymqful9b4jgkXsQEN2wKZTYUyn6NFrsWnXsDMug
         brS/zb9JkvawAi76GRKtlfF7mQiG8IZGuWLcDtHeXg7cAJ9TeXGzIIuwwV1i7Btg2mvm
         oZnmtMMm2FNZsphWumxoIOuwsgBEyzssoBCwCnzdydryVN1iQZKtQs+F3IaMzT4pojmP
         9saVDsu6+Xb14ujirzqpVoFW2sKTOSCvooIc4X1MmidvYJHhmBdwDBAnqOo7iv23Jyvk
         vyEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=Tf0cYXEYI7lttlXn2g/GAMB4YoGAVunv59r6xfp1eHQ=;
        b=qeof4MGoeZPhv/zSpmqw9sbIaxdCu/irIrqt07yl67ak8gqnRXMba8QmaIYCJYcAOZ
         18s+8JPVBp0eVCiWAQLoND9JksvcRuxCCeM09DaeGSJDj0rdn4yEwJQsdUqE24WTXjRM
         2YEff8OgdpNiHut6yAOFZi5QAiR5K3Mwxn3bN2uwieClj2NVmU1qxAhvS33C3Zr0OqER
         wBUg7o3Ebn9Xjf8JRyYeIqfln3CJLbl9RSKNWW93iofzV3vrJXq55CC4MfTG5hU3lA73
         pVnFuHPFprm3aK59Jk4spHCKaodlYXT6oYEIgX4Wbg/RvPsE6r+/6a1yNpafMgx60uSI
         Chag==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=QkibRcE5;
       spf=pass (google.com: domain of kernel-hardening-return-13107-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13107-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=QkibRcE5;
       spf=pass (google.com: domain of kernel-hardening-return-13107-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13107-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 7/9] Pmalloc Rare Write: modify selected pools
To: Matthew Wilcox <willy@infradead.org>
Cc: keescook@chromium.org, paul@paul-moore.com, sds@tycho.nsa.gov,
 mhocko@kernel.org, corbet@lwn.net, labbott@redhat.com, david@fromorbit.com,
 rppt@linux.vnet.ibm.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kernel-hardening@lists.openwall.com, Igor Stoppa <igor.stoppa@huawei.com>,
 Carlos Chinea Perez <carlos.chinea.perez@huawei.com>,
 Remi Denis Courmont <remi.denis.courmont@huawei.com>,
 linux-security-module@vger.kernel.org
References: <20180423125458.5338-1-igor.stoppa@huawei.com>
 <20180423125458.5338-8-igor.stoppa@huawei.com>
 <20180424115050.GD26636@bombadil.infradead.org>
From: Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <98799559-121f-3d9d-343f-b22d30f21b6d@gmail.com>
Date: Tue, 24 Apr 2018 16:33:50 +0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180424115050.GD26636@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598541768538376919?=
X-GMAIL-MSGID: =?utf-8?q?1598630921019991847?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 24/04/18 15:50, Matthew Wilcox wrote:
> On Mon, Apr 23, 2018 at 04:54:56PM +0400, Igor Stoppa wrote:
>> While the vanilla version of pmalloc provides support for permanently
>> transitioning between writable and read-only of a memory pool, this
>> patch seeks to support a separate class of data, which would still
>> benefit from write protection, most of the time, but it still needs to
>> be modifiable. Maybe very seldom, but still cannot be permanently marked
>> as read-only.
> 
> This seems like a horrible idea that basically makes this feature useless.
> I would say the right way to do this is to have:
> 
> struct modifiable_data {
> 	struct immutable_data *d;
> 	...
> };
> 
> Then allocate a new pool, change d and destroy the old pool.

I'm not sure I understand.

The pool, in the patchset, is a collection of related vm_areas.
What I would like to do is to modify some of the memory that has already 
been handed out as reference, in a way that the reference is not 
altered, nor it requires extensive rewites of  all, in place of he usual 
assignment.

Are you saying that my idea is fundamentally broken?
If yes, how to break it? :-)

If not, I need more coffee, pherhaps we can have a cup together later? :-)

--
igor
