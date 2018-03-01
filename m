Return-Path: <jgross@suse.com>
X-Google-Smtp-Source: AG47ELuyR67M/SjO6/fXdEiYCeG0LByQMGMXF0Ey+/etef/8kfkV9O7XwPvzJFffUsr6+QKmJZlr
ARC-Seal: i=1; a=rsa-sha256; t=1519882997; cv=none;
        d=google.com; s=arc-20160816;
        b=hMxObZjtkxS6eV8H0ljC4XRnLZ/n4F4higIMv1cGUOsXZzGZzm57tKfS5/6QE+WWff
         VOIXp00xFUyXLuhcV5Fb+31agpqOe6a85h9Sr3r1XIFey1JNQeo1jdHm9Upw9oDDk7zr
         AUMdhflvAnuQOISOgpppoJxCVIIP3l3zEzscoJ5VsF/sG03fTDWNuF5XZLW4zbS+CuOO
         +CnyV0o8aSzkEL33i7g4J8rUkW25fvwiRA2WTBemg4qeooe663uBvJcvk9nIscKhJD+u
         EtLRQ0sxC+BGnBgO4DAKExutVMQUDlbmN8HhG1cNncCvxLeYDmeXBu3iuARfq5+IVGx6
         UF8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=85rV4ARd6GVsAVM1Ds7x8kf0LloHC1F7pP7wbgBgeTQ=;
        b=YiYLxkMsqbjtP9Wh6Eo3fNVVzGdyj4DjseSl6nHwi5Wx+fJv0UNCmnmZbdQqa38Ogl
         WCDBgAjDessGRmBq1oqfKxJwGqnN5W4Wx5B+M8GRk02UN17EyZ9pM5N//oH6jIAh5oeE
         rn+RtyRQpelerGztk7fPwGjHXsljKFB84XOqzPzd84RFPwV0N+gHhEzKruwrLKni8f8R
         65t+fOD8NAB9xz9zsU3IDaH17ebvM5EapneQxHNyIrCq/bYmIpyoK+D9B/YNVX5EXTD8
         xvl9NW4/7mnuPuDqTG3Wk+yNUtIoWmClj6o/qLz+ed9vyk2knLXo5mZkn9dCZ9sYIFGH
         H/+g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jgross@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=jgross@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jgross@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=jgross@suse.com
Subject: Re: [Xen-devel] [RFC PATCH v4 1/7] xen/pvh: Split CONFIG_XEN_PVH into
 CONFIG_PVH and CONFIG_XEN_PVH
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Maran Wilson <maran.wilson@oracle.com>
Cc: pbonzini@redhat.com, boris.ostrovsky@oracle.com, roger.pau@citrix.com,
 andrew.cooper3@citrix.com, hch@infradead.org, JBeulich@suse.com,
 x86@kernel.org, xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, thomas.lendacky@amd.com,
 dave.hansen@linux.intel.com, rkrcmar@redhat.com, gregkh@linuxfoundation.org,
 mchehab@kernel.org, hpa@zytor.com, linus.walleij@linaro.org,
 mingo@redhat.com, rdunlap@infradead.org, luto@kernel.org,
 jpoimboe@redhat.com, tglx@linutronix.de, bp@suse.de, davem@davemloft.net,
 kirill.shutemov@linux.intel.com
References: <1519842483-8887-1-git-send-email-maran.wilson@oracle.com>
 <1519842483-8887-2-git-send-email-maran.wilson@oracle.com>
 <20180228210734.GJ11576@char.us.oracle.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <65c9ea8b-0954-52b5-090f-9212573656c9@suse.com>
Date: Thu, 1 Mar 2018 06:43:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180228210734.GJ11576@char.us.oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593670432609567761?=
X-GMAIL-MSGID: =?utf-8?q?1593712833248048216?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 28/02/18 22:07, Konrad Rzeszutek Wilk wrote:
> On Wed, Feb 28, 2018 at 10:27:57AM -0800, Maran Wilson wrote:
>> In order to pave the way for hypervisors other then Xen to use the PVH
>> entry point for VMs, we need to factor the PVH entry code into Xen specific
>> and hypervisor agnostic components. The first step in doing that, is to
>> create a new config option for PVH entry that can be enabled
>> independently from CONFIG_XEN.
>>
>> Signed-off-by: Maran Wilson <maran.wilson@oracle.com>
>> ---
>>  arch/x86/Kconfig          | 8 ++++++++
>>  arch/x86/kernel/head_64.S | 4 ++--
>>  arch/x86/xen/Kconfig      | 3 ++-
>>  3 files changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index eb7f43f23521..fa7cd0305125 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -791,6 +791,14 @@ config KVM_GUEST
>>  	  underlying device model, the host provides the guest with
>>  	  timing infrastructure such as time of day, and system time
>>  
>> +config PVH
>> +	bool "Support for running PVH guests"
>> +	depends on KVM_GUEST || XEN
>> +	def_bool n
>> +	---help---
>> +	  This option enables the PVH entry point for guest virtual machines
>> +	  as specified in the x86/HVM direct boot ABI.
>> +
>>  config KVM_DEBUG_FS
>>  	bool "Enable debug information for KVM Guests in debugfs"
>>  	depends on KVM_GUEST && DEBUG_FS
>> diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
>> index 0f545b3cf926..fc9f678c6413 100644
>> --- a/arch/x86/kernel/head_64.S
>> +++ b/arch/x86/kernel/head_64.S
>> @@ -41,7 +41,7 @@
>>  
>>  #define pud_index(x)	(((x) >> PUD_SHIFT) & (PTRS_PER_PUD-1))
>>  
>> -#if defined(CONFIG_XEN_PV) || defined(CONFIG_XEN_PVH)
>> +#if defined(CONFIG_XEN_PV) || defined(CONFIG_PVH)
>>  PGD_PAGE_OFFSET = pgd_index(__PAGE_OFFSET_BASE)
>>  PGD_START_KERNEL = pgd_index(__START_KERNEL_map)
>>  #endif
>> @@ -387,7 +387,7 @@ NEXT_PAGE(early_dynamic_pgts)
>>  
>>  	.data
>>  
>> -#if defined(CONFIG_XEN_PV) || defined(CONFIG_XEN_PVH)
>> +#if defined(CONFIG_XEN_PV) || defined(CONFIG_PVH)
>>  NEXT_PGD_PAGE(init_top_pgt)
>>  	.quad   level3_ident_pgt - __START_KERNEL_map + _KERNPG_TABLE_NOENC
>>  	.org    init_top_pgt + PGD_PAGE_OFFSET*8, 0
>> diff --git a/arch/x86/xen/Kconfig b/arch/x86/xen/Kconfig
>> index f605825a04ab..021c8591c3c0 100644
>> --- a/arch/x86/xen/Kconfig
>> +++ b/arch/x86/xen/Kconfig
>> @@ -77,8 +77,9 @@ config XEN_DEBUG_FS
>>  	  Enabling this option may incur a significant performance overhead.
>>  
>>  config XEN_PVH
>> -	bool "Support for running as a PVH guest"
>> +	bool "Support for running as a Xen PVH guest"
>>  	depends on XEN && XEN_PVHVM && ACPI
>>  	# Pre-built page tables are not ready to handle 5-level paging.
>>  	depends on !X86_5LEVEL
> 
> Not specific to this patch, but why is this there? PVH is not using PV so
> there should be no problems with 5 level paging.
> 
> Juergen, thoughts?

This dependency will be removed with Kyrill's series enabling to boot
the same kernel with either 5- or 4-level paging.

Adding 5-level paging support to the PVH boot path could be done later.
OTOH the same could be achieved by using grub2 to boot in PVH mode (with
my grub2 PVH series) as this variant is using the common Linux boot
entry, not the PVH specific one.


Juergen
