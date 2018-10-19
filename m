Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31397ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 13:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1A1021476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 13:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sNlbMzhB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1A1021476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbeJSVtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 17:49:25 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56278 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbeJSVtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 17:49:25 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9JDg6rt192674;
        Fri, 19 Oct 2018 13:43:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=ssOBaF36picrzCWuXk4kfetqmNIheX0y+E9kzVPg5v8=;
 b=sNlbMzhBJlbztL+Gi6Ttiqsqf8zorU/klK7b2VHnN3tVmZS45BSAt+X5MSYcVdWLBk2v
 aMxsOx80nb+j0kudEjkSNlMHqqUYxR5tU6YxwWo3zqMSeVCOld2QJNT3MyoDGGt7CReB
 r2+A5mcAzt9nS0iHguieAy+aBJpE5vS+ExjbZhLYC/UPkxESdMsjbISnAIrJGmODVn6j
 rId1QrJrEn00AuUm1Xk8xIUFFYdadlcwBojZRuxHUIxjlxjq8DlofuZWWrh9MWEUZjg1
 F2VhF/jbuKYfqoqtBv1ZsdwrdQQycqWj1lzVYLbynxgyJUrZGkew7ctGmYMBEFbTP1qc zw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2n384um9uv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Oct 2018 13:43:07 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9JDh67x013449
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Oct 2018 13:43:07 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9JDh6q0010922;
        Fri, 19 Oct 2018 13:43:06 GMT
Received: from Konrads-MacBook-Pro.local (/10.39.209.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 19 Oct 2018 06:43:06 -0700
Date:   Fri, 19 Oct 2018 09:43:03 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Joe Jin <joe.jin@oracle.com>
Cc:     John Sobecki <john.sobecki@oracle.com>,
        "DONGLI.ZHANG" <dongli.zhang@oracle.com>, konrad@kernel.org,
        Christoph Helwig <hch@lst.de>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] xen-swiotlb: use actually allocated size on check
 physical continuous
Message-ID: <20181019134303.GC54336@Konrads-MacBook-Pro.local>
References: <0453c762-1f8b-079f-5fdf-548e90909318@oracle.com>
 <20181018235219.GA36047@konrads-mbp.lan>
 <e476c3e8-d501-c5c6-d389-8b0b33adf4b1@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e476c3e8-d501-c5c6-d389-8b0b33adf4b1@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9050 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810190123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 07:16:04PM -0700, Joe Jin wrote:
> On 10/18/18 4:52 PM, Konrad Rzeszutek Wilk wrote:
> > On Tue, Oct 16, 2018 at 03:21:16PM -0700, Joe Jin wrote:
> >> xen_swiotlb_{alloc,free}_coherent() allocate/free memory by order,
> >> but passed required size to range_straddles_page_boundary(),
> >> when first pages are physical continuous,
> >> range_straddles_page_boundary() returned true, then did not
> >> exchanged memory with Xen, later on free memory, it tried to
> >> exchanged non-contiguous memory with Xen, then kernel panic.
> > 
> > I have a hard time understanding the commit message.
> > 
> > I think you mean to say:
> > 
> > xen_swiotlb_{alloc,free}_coherent() allocate/free memory based on the
> > order of the pages and not size argument (bytes). This is inconsistent with
> > range_straddles_page_boundary and memset which use the 'size' value,
> > which may lead to not exchanging memory with Xen (range_straddles_page_boundary()
> > returned true). And then the call to xen_swiotlb_free_coherent() would
> > actually try to exchange the memory with Xen, leading to the kernel
> > hitting an BUG (as the hypercall returned an error).
> 
> Sorry for the confusing, yes you right.
> 
> BTW: panic triggered by xen_remap_exchanged_ptes()->xen_mc_issue().
> 
> Panic calltrace as below:
> 
>  [ 1129.150648] WARNING: CPU: 1 PID: 21001 at arch/x86/xen/multicalls.c:129
> xen_mc_flush+0x1ce/0x1e0()
> [ 1129.150653] Modules linked in: ocfs2 mptctl mptbase xen_netback
> xen_blkback xen_gntalloc xen_gntdev xen_evtchn xenfs xen_privcmd ocfs2_dlmfs
> ocfs2_stack_o2cb ocfs2_dlm ocfs2_nodemanager ocfs2_stackglue configfs bnx2fc
> fcoe libfcoe libfc sunrpc 8021q mrp garp bridge stp llc bonding
> dm_round_robin dm_multipath iTCO_wdt iTCO_vendor_support pcspkr shpchp
> sb_edac edac_core i2c_i801 i2c_core cdc_ether usbnet mii lpc_ich mfd_core
> ioatdma sg ipmi_devintf ipmi_si ipmi_msghandler ext4 jbd2 mbcache2 sd_mod
> usb_storage ahci libahci megaraid_sas ixgbe dca ptp pps_core vxlan udp_tunnel
> ip6_udp_tunnel qla2xxx scsi_transport_fc crc32c_intel be2iscsi bnx2i cnic uio
> cxgb4i cxgb4 cxgb3i libcxgbi ipv6 cxgb3 mdio libiscsi_tcp qla4xxx
> iscsi_boot_sysfs libiscsi scsi_transport_iscsi wmi dm_mirror dm_region_hash
> dm_log dm_mod
> [ 1129.150719]
> [ 1129.150722] CPU: 1 PID: 21001 Comm: blkid Tainted: G        W        
> 4.1.12-124.16.3.el6uek.x86_64 #2
> [ 1129.150723] Hardware name: Oracle Corporation ORACLE SERVER
> X5-2/ASM,MOTHERBOARD,1U, BIOS 30130400 02/08/2018
> [ 1129.150727]  0000000000000000 ffff8803ec7c3c78 ffffffff816e52a3
> 0000000000000000
> [ 1129.150732]  ffffffff819bc5c3 ffff8803ec7c3cb8 ffffffff8108481a
> ffff8803ec7c3d18
> [ 1129.150735]  ffff8804a6a4d2c0 0000000000000003 ffff8804994df800
> 0000000000000001
> [ 1129.150740] Call Trace:
> [ 1129.150746]  [<ffffffff816e52a3>] dump_stack+0x63/0x81
> [ 1129.150753]  [<ffffffff8108481a>] warn_slowpath_common+0x8a/0xc0
> [ 1129.150756]  [<ffffffff8108490a>] warn_slowpath_null+0x1a/0x20
> [ 1129.150759]  [<ffffffff8100559e>] xen_mc_flush+0x1ce/0x1e0
> [ 1129.150764]  [<ffffffff81007af9>] __xen_pgd_unpin+0x109/0x250
> [ 1129.150767]  [<ffffffff81007db7>] xen_exit_mmap+0x177/0x2a0
> [ 1129.150770]  [<ffffffff811c3628>] exit_mmap+0x48/0x160
> [ 1129.150776]  [<ffffffff8112c68c>] ? __audit_free+0x1cc/0x220
> [ 1129.150784]  [<ffffffff811e725e>] ? kfree+0x16e/0x180
> [ 1129.150787]  [<ffffffff81081cf3>] mmput+0x63/0x100
> [ 1129.150790]  [<ffffffff81087263>] do_exit+0x343/0xa90
> [ 1129.150793]  [<ffffffff8112c794>] ? __audit_syscall_entry+0xb4/0x110
> [ 1129.150796]  [<ffffffff81025a2c>] ? do_audit_syscall_entry+0x6c/0x70
> [ 1129.150799]  [<ffffffff81087a45>] do_group_exit+0x45/0xb0
> [ 1129.150805]  [<ffffffff81087ac4>] SyS_exit_group+0x14/0x20
> [ 1129.150807]  [<ffffffff816edc5c>] system_call_fastpath+0x18/0xd6
> [ 1129.150810] ---[ end trace 7aec0081e2a07193 ]---
> 
> Do you think the patch fine or no? if yes I'll reorg patch description
> and resend it.

I will fold in the stack trace in later tonight. Thanks!
> 
> Thanks,
> Joe
> 
> > 
> > This patch fixes it by making the 'size' variable be of the same size
> > as the amount of memory allocated.
> > 
> > I checked it as such..
> >>
> >> Signed-off-by: Joe Jin <joe.jin@oracle.com>
> >> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> >> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> >> Cc: Christoph Helwig <hch@lst.de>
> >> Cc: Dongli Zhang <dongli.zhang@oracle.com>
> >> Cc: John Sobecki <john.sobecki@oracle.com>
> >>
> >> ---
> >>  drivers/xen/swiotlb-xen.c | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >>
> >> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> >> index a6f9ba85dc4b..aa081f806728 100644
> >> --- a/drivers/xen/swiotlb-xen.c
> >> +++ b/drivers/xen/swiotlb-xen.c
> >> @@ -303,6 +303,9 @@ xen_swiotlb_alloc_coherent(struct device *hwdev, size_t size,
> >>  	*/
> >>  	flags &= ~(__GFP_DMA | __GFP_HIGHMEM);
> >>  
> >> +	/* Convert the size to actually allocated. */
> >> +	size = 1UL << (order + XEN_PAGE_SHIFT);
> >> +
> >>  	/* On ARM this function returns an ioremap'ped virtual address for
> >>  	 * which virt_to_phys doesn't return the corresponding physical
> >>  	 * address. In fact on ARM virt_to_phys only works for kernel direct
> >> @@ -351,6 +354,9 @@ xen_swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
> >>  	 * physical address */
> >>  	phys = xen_bus_to_phys(dev_addr);
> >>  
> >> +	/* Convert the size to actually allocated. */
> >> +	size = 1UL << (order + XEN_PAGE_SHIFT);
> >> +
> >>  	if (((dev_addr + size - 1 <= dma_mask)) ||
> >>  	    range_straddles_page_boundary(phys, size))
> >>  		xen_destroy_contiguous_region(phys, order);
> >> -- 
> >> 2.15.2 (Apple Git-101.1)
> >>
> >>
> 
> 
> -- 
> Oracle <http://www.oracle.com>
> Joe Jin | Software Development Director 
> ORACLE | Linux and Virtualization
> 500 Oracle Parkway Redwood City, CA US 94065
