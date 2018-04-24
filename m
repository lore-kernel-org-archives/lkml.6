Return-Path: <kernel-hardening-return-13109-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4+ZjCSI6rmkhd+wetN4Uwg0RX357VxHzvi/hcKeVMFl7NOMzt/5l2y56O947y4n03HnM4i1
ARC-Seal: i=1; a=rsa-sha256; t=1524576425; cv=none;
        d=google.com; s=arc-20160816;
        b=NmAD9OVtNEwOUKWpJPF3ilUAwurUQLDclWqaGEi3z41pD60XvmdoC/9SWTNAMmR0eN
         CeCbWTqecTU+CBGa4k3fII4Savc3vsXMGD/FLPYDgyyQQfEmlCV2ZpW+0xaT+9Pj4FRo
         sXvWh4QQoEl4IpshoQIpT/+L1WpYO5UAzsCFabBN4am6d13Qvl1/ZPfxdmOtxclqiavX
         e9pQjtJZYiIxP6iv1qEioHHYASyjiINKm45z8hvCdGV0vUCx9pfdgggNdltwQMvJYgiK
         aUe752Dtnq4Sj5S0+w58CrMbSu06qVR+UcgNWH6cYrpgC8nGlpKhbI0DE0crDcsrM0nZ
         Q2Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:delivered-to:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=Lk2/KwrHJdO0WurFYLgCDEX2OpwPBgP9SIx/6mvI3cU=;
        b=AKy899phU5oC0tLgT7arnO0c2MU4wdv4ppX8ns3zDKrNOAypQK865rNviXjsg43mn4
         xAYKpJ1BukyyW/Wf5oxg3G+cY6NH4/Ri5dXseJyOpCNiXZiTYkQm0H1njK6AfSkwqIyf
         +ZBz5n5g+HOUBqmbB9d258K2hE1yUwG5mStexotQhQLHOwCvI2G9Kb54bzGhlAYlXR2e
         jwcszX87lKW11rQ72KKyFpVme7ZIA9EtJLQks62YKsNjPMo8FIvDBArdDSO7lmHvcTum
         7V60hahHH2/tojhNkGZTuClpAcd0rtKb4n87yjjR9pIhfKJe8KHS/5YbEmOEL/6xy+bi
         qVxw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=rso155Nc;
       spf=pass (google.com: domain of kernel-hardening-return-13109-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13109-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=rso155Nc;
       spf=pass (google.com: domain of kernel-hardening-return-13109-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13109-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 7/9] Pmalloc Rare Write: modify selected pools
To: Matthew Wilcox <willy@infradead.org>, Igor Stoppa <igor.stoppa@gmail.com>
Cc: keescook@chromium.org, paul@paul-moore.com, sds@tycho.nsa.gov,
 mhocko@kernel.org, corbet@lwn.net, labbott@redhat.com,
 linux-cc=david@fromorbit.com, --cc=rppt@linux.vnet.ibm.com,
 --security-module@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
 Igor Stoppa <igor.stoppa@huawei.com>,
 Carlos Chinea Perez <carlos.chinea.perez@huawei.com>,
 Remi Denis Courmont <remi.denis.courmont@huawei.com>
References: <20180423125458.5338-1-igor.stoppa@huawei.com>
 <20180423125458.5338-8-igor.stoppa@huawei.com>
 <20180424115050.GD26636@bombadil.infradead.org>
From: lazytyped <lazytyped@gmail.com>
Message-ID: <eb23fbd9-1b9e-8633-b0eb-241b8ad24d95@gmail.com>
Date: Tue, 24 Apr 2018 14:32:36 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180424115050.GD26636@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598541768538376919?=
X-GMAIL-MSGID: =?utf-8?q?1598634249765765420?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 4/24/18 1:50 PM, Matthew Wilcox wrote:
> struct modifiable_data {
> 	struct immutable_data *d;
> 	...
> };
>
> Then allocate a new pool, change d and destroy the old pool.

With the above, you have just shifted the target of the arbitrary write
from the immutable data itself to the pointer to the immutable data, so
got no security benefit.

The goal of the patch is to reduce the window when stuff is writeable,
so that an arbitrary write is likely to hit the time when data is read-only.


       -  Enrico
