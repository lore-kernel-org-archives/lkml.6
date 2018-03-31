Return-Path: <xieyisheng1@huawei.com>
X-Google-Smtp-Source: AIpwx4/yxYFk+aKbM5cgHy0JIEx6L3xVXtAeR1x2YJos5dfTl1mKwhxOJ1R9FNiBayjeFtW+JWBv
ARC-Seal: i=1; a=rsa-sha256; t=1522459668; cv=none;
        d=google.com; s=arc-20160816;
        b=MOuD5C1iwV86nqwsrQBqd44gA/mmNiz9lrsfCrlhE+lljX9Fo1+sKDQtZwH/QsAqb+
         Iy0+8CJEdyhEB14ZbE7gODDoDS9UM1cEc+Tzi7CUXDreRirP21XTtlhYZI8UOR18NLtX
         fWxzY9RwnOILX4/qUAn5UUgwApsAjMdGQ8Px180kyS6oEzXlVpkafMAitF/o1qzt1BPP
         vt3G/X3dDUmLpzOioPtk8JJyijh0dngB0HKKWmnF65UrYQk3RGplpczDK1KG2dlwt4U0
         krCgdh4eYm/p/O/MYy5I1XbpNFuTH7XlS75KHqb9rvQMAkbe5oKJodQtc4+WFhnlhfSV
         IFkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:arc-authentication-results;
        bh=iqmlgjlH2qirB/92UafUW+Lb4NjEKSk0OiYMK4fv7Ug=;
        b=msyf6JuEaUpA3BaoSTJ1CatbF3qC/pUdHTnhuGJmSmGNk6CXG7fQrWNySWayzfykgJ
         34Y985VRUXyLwovw6WL4TPookv1N7izeHdg6ofigdXdnNRrO5erXrdViqH6e8tjjrB/Q
         De5Wjb8S6aq7aHAU0sNBWjJwd0u6s4G3Yl1MXhrAigcOgJQzwixufhmeXESVKkZLbDoi
         WrYgmK23jMX2/PCOW5kq6X5j4YBkl5v7uRpdb1eFGik7L2vdb6ayiAh/kw4SWCjFrzUS
         9SMhD5FNJBu+FNHGrvd9khAODApxdChE9xPFjr0d7pVR4kTZpnh/793ka0Axto/F3x7v
         2ICg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of xieyisheng1@huawei.com designates 45.249.212.190 as permitted sender) smtp.mailfrom=xieyisheng1@huawei.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of xieyisheng1@huawei.com designates 45.249.212.190 as permitted sender) smtp.mailfrom=xieyisheng1@huawei.com
Subject: Re: [RFC PATCH] lib/ioremap: Avoid triggering BUG_ON when end is not
 PAGE_ALIGN
To: "Kani, Toshi" <toshi.kani@hpe.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>
References: <1522385385-7074-1-git-send-email-xieyisheng1@huawei.com>
 <1522431689.2693.290.camel@hpe.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"guohanjun@huawei.com" <guohanjun@huawei.com>, "tanxiaojun@huawei.com"
	<tanxiaojun@huawei.com>, "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
	"kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "arnd@arndb.de"
	<arnd@arndb.de>, "jcm@redhat.com" <jcm@redhat.com>
From: Yisheng Xie <xieyisheng1@huawei.com>
Message-ID: <9c186ae8-6350-e1ab-001a-23ae87ce030d@huawei.com>
Date: Sat, 31 Mar 2018 09:27:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
MIME-Version: 1.0
In-Reply-To: <1522431689.2693.290.camel@hpe.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.40]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596337453491201592?=
X-GMAIL-MSGID: =?utf-8?q?1596414669496867006?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Toshi,

On 2018/3/31 1:41, Kani, Toshi wrote:
> On Fri, 2018-03-30 at 12:49 +0800, Yisheng Xie wrote:
>> Zhou reported a bug on Hisilicon arm64 D06 platform with 64KB page size:
>  :
>> The cause is the size of PCI IO resource is 32KB, which is 4K aligned but
>> not 64KB aligned, so when do ioremap_pte_range(), its incoming end is not
>> PAGE_ALIGN on 64KB page size system, but ioremap_pte_range increase the
>> addr by PAGE_SIZE, which makes addr != end until trigger BUG_ON.
>>
>> This patch introduces pte_addr_end(addr, end) to resolve this problem, just
>> as what pmd_addr_end do. When end is not PAGE_ALIGN, it will return end
>> instead of addr + PAGE_SIZE, therefore ioremap_pte_range() can break out
>> when real end is coming.
> 
> ioremap_pte_range() assumes that addr and end are aligned by PAGE_SIZE. 
> While some improvement can be made in the range check and documentation,
>  I do not think it is safe for letting this library function to map
> outside of a requested range blindly.
> 
> Can you change the caller of ioremap_page_range() to align the request
> by PAGE_SIZE so that the caller is aware of what it's asking for? 

Sure, as the name of ioremap_*page*_range(), the caller should make sure align
the request by PAGE_SIZE.

Thanks
Yisheng
> 
> Thanks,
> -Toshi
> 
