Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A78BC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 415F6277F5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:50:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 415F6277F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967993AbeF1SuP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 14:50:15 -0400
Received: from mga09.intel.com ([134.134.136.24]:26182 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966880AbeF1SuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 14:50:12 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jun 2018 11:50:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,284,1526367600"; 
   d="scan'208";a="211959149"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by orsmga004.jf.intel.com with ESMTP; 28 Jun 2018 11:49:53 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fYbzM-000Wfd-29; Fri, 29 Jun 2018 02:49:52 +0800
Date:   Fri, 29 Jun 2018 02:49:43 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kbuild-all@01.org, kvm@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>,
        Cathy Avery <cavery@redhat.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] KVM: x86: hyperv: introduce vp_index_to_vcpu_idx
 mapping
Message-ID: <201806290206.aMbkOcrB%fengguang.wu@intel.com>
References: <20180628135313.17468-3-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628135313.17468-3-vkuznets@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vitaly,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on kvm/linux-next]
[also build test WARNING on v4.18-rc2 next-20180628]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Vitaly-Kuznetsov/KVM-x86-hyperv-PV-IPI-support-for-Windows-guests/20180629-011544
base:   https://git.kernel.org/pub/scm/virt/kvm/kvm.git linux-next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> arch/x86/kvm/hyperv.c:156:15: sparse: incompatible types in comparison expression (different address spaces)
   arch/x86/kvm/hyperv.c:195:15: sparse: incompatible types in comparison expression (different address spaces)

vim +156 arch/x86/kvm/hyperv.c

   136	
   137	static u32 vp_idx_to_vcpu_idx(struct kvm *kvm, u32 vp_idx)
   138	{
   139		struct kvm_hv *hv = &kvm->arch.hyperv;
   140		u32 vcpu_idx = U32_MAX, tmp_vp_idx;
   141		int l_index = 0, r_index, tmp_index;
   142		struct vp_idx_map *map;
   143	
   144		/*
   145		 * Make an educated guess: vp_idx is initialized to == vcpu_idx, it
   146		 * stays this way unless changed by userspace.
   147		 */
   148		if (vp_idx < KVM_MAX_VCPUS) {
   149			struct kvm_vcpu *vcpu = kvm_get_vcpu(kvm, vp_idx);
   150	
   151			if (vcpu && vcpu_to_hv_vcpu(vcpu)->vp_index == vp_idx)
   152				return vp_idx;
   153		}
   154	
   155		rcu_read_lock();
 > 156		map = rcu_dereference(hv->vp_idx_map);
   157		if (!map)
   158			goto unlock;
   159	
   160		r_index = map->len - 1;
   161	
   162		while (r_index >= l_index) {
   163			tmp_index = (r_index + l_index)/2;
   164			tmp_vp_idx = map->vp_idx_elem[tmp_index].vp_idx;
   165	
   166			if (tmp_vp_idx == vp_idx) {
   167				vcpu_idx = map->vp_idx_elem[tmp_index].vcpu_idx;
   168				break;
   169			} else if (tmp_vp_idx < vp_idx) {
   170				l_index = tmp_index + 1;
   171			} else /* (tmp_vp_idx > vp_idx) */ {
   172				r_index = tmp_index - 1;
   173			}
   174		};
   175	
   176	unlock:
   177		rcu_read_unlock();
   178	
   179		return vcpu_idx;
   180	}
   181	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
