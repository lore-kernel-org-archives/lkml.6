Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752620AbeBWXsw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 18:48:52 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:35805 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752134AbeBWXsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 18:48:50 -0500
X-IronPort-AV: E=Sophos;i="5.47,385,1515456000";
   d="scan'208";a="709386285"
From: "Raslan, KarimAllah" <karahmed@amazon.de>
To: "lkp@intel.com" <lkp@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jmattson@google.com" <jmattson@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "kbuild-all@01.org" <kbuild-all@01.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>
Subject: Re: [PATCH 04/10] KVM: Introduce a new guest mapping API
Thread-Topic: [PATCH 04/10] KVM: Introduce a new guest mapping API
Thread-Index: AQHTqzwRh6xTNa75zUazC6wfebjQuKOxN2AAgAFz1oA=
Date: Fri, 23 Feb 2018 23:48:45 +0000
Message-ID: <1519429725.13144.18.camel@amazon.de>
References: <1519235241-6500-5-git-send-email-karahmed@amazon.de>
         <201802230932.mejQTowq%fengguang.wu@intel.com>
In-Reply-To: <201802230932.mejQTowq%fengguang.wu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.166.199]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A986CBFA1FBD284D9C7E3867DC7CD2E3@amazon.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1NNmuQN010205

On Fri, 2018-02-23 at 09:37 +0800, kbuild test robot wrote:
> Hi KarimAllah,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on tip/auto-latest]
> [also build test ERROR on v4.16-rc2 next-20180222]
> [cannot apply to kvm/linux-next]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/KarimAllah-Ahmed/KVM-X86-Handle-guest-memory-that-does-not-have-a-struct-page/20180223-064826
> config: mips-malta_kvm_defconfig (attached as .config)
> compiler: mipsel-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=mips 
> 
> All error/warnings (new ones prefixed by >>):
> 
>    In file included from include/linux/linkage.h:7:0,
>                     from include/linux/preempt.h:10,
>                     from include/linux/hardirq.h:5,
>                     from include/linux/kvm_host.h:10,
>                     from arch/mips/kvm/../../../virt/kvm/kvm_main.c:21:
> > 
> > > 
> > > arch/mips/kvm/../../../virt/kvm/kvm_main.c:1669:19: error: 'kvm_vcpu_gfn_to_kaddr' undeclared here (not in a function); did you mean 'kvm_vcpu_gfn_to_page'?
>     EXPORT_SYMBOL_GPL(kvm_vcpu_gfn_to_kaddr);
>                       ^
>    include/linux/export.h:65:16: note: in definition of macro '___EXPORT_SYMBOL'
>      extern typeof(sym) sym;      \
>                    ^~~
> > 
> > > 
> > > arch/mips/kvm/../../../virt/kvm/kvm_main.c:1669:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
>     EXPORT_SYMBOL_GPL(kvm_vcpu_gfn_to_kaddr);
>     ^~~~~~~~~~~~~~~~~

Ooops! I will make sure I build KVM as a module as well before posting 
v2.

I will also drop "kvm_vcpu_map_valid" since it is no longer used.

> 
> vim +1669 arch/mips/kvm/../../../virt/kvm/kvm_main.c
> 
>   1634	
>   1635	bool kvm_vcpu_map(struct kvm_vcpu *vcpu, gfn_t gfn, struct kvm_host_map *map)
>   1636	{
>   1637		kvm_pfn_t pfn;
>   1638		void *kaddr = NULL;
>   1639		struct page *page = NULL;
>   1640	
>   1641		if (map->kaddr && map->gfn == gfn)
>   1642			/* If the mapping is valid and guest memory is already mapped */
>   1643			return true;
>   1644		else if (map->kaddr)
>   1645			/* If the mapping is valid but trying to map a different guest pfn */
>   1646			kvm_vcpu_unmap(map);
>   1647	
>   1648		pfn = kvm_vcpu_gfn_to_pfn(vcpu, gfn);
>   1649		if (is_error_pfn(pfn))
>   1650			return false;
>   1651	
>   1652		if (pfn_valid(pfn)) {
>   1653			page = pfn_to_page(pfn);
>   1654			kaddr = vmap(&page, 1, VM_MAP, PAGE_KERNEL);
>   1655		} else {
>   1656			kaddr = memremap(pfn_to_hpa(pfn), PAGE_SIZE, MEMREMAP_WB);
>   1657		}
>   1658	
>   1659		if (!kaddr)
>   1660			return false;
>   1661	
>   1662		map->page = page;
>   1663		map->kaddr = kaddr;
>   1664		map->pfn = pfn;
>   1665		map->gfn = gfn;
>   1666	
>   1667		return true;
>   1668	}
> > 
> > 1669	EXPORT_SYMBOL_GPL(kvm_vcpu_gfn_to_kaddr);
>   1670	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B
