Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7AD3C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64200252CE
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:28:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64200252CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752788AbeGBQ2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 12:28:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59756 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752728AbeGBQ2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 12:28:49 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EBC2240250FF;
        Mon,  2 Jul 2018 16:28:48 +0000 (UTC)
Received: from gondolin (ovpn-117-51.ams2.redhat.com [10.36.117.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3168D2166B5D;
        Mon,  2 Jul 2018 16:28:44 +0000 (UTC)
Date:   Mon, 2 Jul 2018 18:28:40 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Tony Krowiak <akrowiak@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Tony Krowiak <akrowiak@linux.vnet.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com,
        pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
Subject: Re: [PATCH v6 05/21] KVM: s390: CPU model support for AP
 virtualization
Message-ID: <20180702182840.34560fed.cohuck@redhat.com>
In-Reply-To: <76165cca-b8ec-172a-4a1b-6f3514b44344@linux.ibm.com>
References: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1530306683-7270-6-git-send-email-akrowiak@linux.vnet.ibm.com>
        <ceb1d797-9bb3-cb6e-c510-657fc61a7f82@de.ibm.com>
        <276b5ae7-7f27-faae-1e5a-0d4c084139e9@linux.ibm.com>
        <20180702174103.5d1ce603.cohuck@redhat.com>
        <d1eb3115-cc3c-cc4f-b683-1a660aa0c6c9@linux.ibm.com>
        <20180702181108.2c721a86.cohuck@redhat.com>
        <76165cca-b8ec-172a-4a1b-6f3514b44344@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 02 Jul 2018 16:28:49 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 02 Jul 2018 16:28:49 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'cohuck@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Jul 2018 18:20:55 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On 07/02/2018 06:11 PM, Cornelia Huck wrote:
> > On Mon, 2 Jul 2018 11:54:28 -0400
> > Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> >   
> >> On 07/02/2018 11:41 AM, Cornelia Huck wrote:  
> >>> On Mon, 2 Jul 2018 11:37:11 -0400
> >>> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> >>>     
> >>>> On 07/02/2018 10:38 AM, Christian Borntraeger wrote:  
> >>>>> On 06/29/2018 11:11 PM, Tony Krowiak wrote:  
> >>>>>> Introduces a new CPU model feature and two CPU model
> >>>>>> facilities to support AP virtualization for KVM guests.
> >>>>>>
> >>>>>> CPU model feature:
> >>>>>>
> >>>>>> The KVM_S390_VM_CPU_FEAT_AP feature indicates that
> >>>>>> AP instructions are available on the guest. This
> >>>>>> feature will be enabled by the kernel only if the AP
> >>>>>> instructions are installed on the linux host. This feature
> >>>>>> must be specifically turned on for the KVM guest from
> >>>>>> userspace to use the VFIO AP device driver for guest
> >>>>>> access to AP devices.
> >>>>>>
> >>>>>> CPU model facilities:
> >>>>>>
> >>>>>> 1. AP Query Configuration Information (QCI) facility is installed.
> >>>>>>
> >>>>>>       This is indicated by setting facilities bit 12 for
> >>>>>>       the guest. The kernel will not enable this facility
> >>>>>>       for the guest if it is not set on the host. This facility
> >>>>>>       must not be set by userspace if the KVM_S390_VM_CPU_FEAT_AP
> >>>>>>       feature is not installed.
> >>>>>>
> >>>>>>       If this facility is not set for the KVM guest, then only
> >>>>>>       APQNs with an APQI less than 16 will be available to the
> >>>>>>       guest regardless of the guest's matrix configuration. This
> >>>>>>       is a limitation of the AP bus running on the guest.
> >>>>>>
> >>>>>> 2. AP Facilities Test facility (APFT) is installed.
> >>>>>>
> >>>>>>       This is indicated by setting facilities bit 15 for
> >>>>>>       the guest. The kernel will not enable this facility for
> >>>>>>       the guest if it is not set on the host. This facility
> >>>>>>       must not be set by userspace if the KVM_S390_VM_CPU_FEAT_AP
> >>>>>>       feature is not installed.
> >>>>>>
> >>>>>>       If this facility is not set for the KVM guest, then no
> >>>>>>       AP devices will be available to the guest regardless of
> >>>>>>       the guest's matrix configuration. This is a limitation
> >>>>>>       of the AP bus running under the guest.
> >>>>>>
> >>>>>> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> >>>>>> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> >>>>>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>  
> >>>>> I think it probably should be at the end of the series, other than that its good.  
> >>>> If I move this to the end of the series, the very next patch checks the
> >>>>
> >>>> KVM_S390_VM_CPU_FEAT_AP feature?  
> >>> Introduce it here, offer it only with the last patch?  
> >>
> >> I apologize, but I don't know what you mean by this. Are you suggesting
> >> this patch
> >> should only include the #define for KVM_S390_VM_CPU_FEAT_AP?  
> > 
> > Yes, just introduce the definition here (so code later in the series
> > can refer to it) and flip the switch (offer the bit) as the final
> > patch.
> >   
> 
> The other features introduced and exposed here are no different. For
> KVM_S390_VM_CPU_FEAT_AP defer exposing means defer allow_cpu_feat();
> for the STFLE features, defer adding to FACILITIES_KVM_CPUMODEL.
> 
> Anyway, I think the definition should be squashed into #6. Expose the
> features after patch #6 is in place or expose them at the end of the
> series is IMHO a matter of taste -- and I lean towards expose at the
> end of the series.

Squashing with patch 6 and enabling at the end of the series sounds
good to me as well.
