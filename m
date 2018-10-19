Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E615C67863
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 02:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0DC920C0E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 02:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="3dSz3Bg8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0DC920C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbeJSKUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 06:20:07 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60458 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbeJSKUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 06:20:07 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9J2CORg071075;
        Fri, 19 Oct 2018 02:16:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=SDsbuCf9ecf7ECncJ+QWZi9Gh8EknwCEIRrUmnvyQPA=;
 b=3dSz3Bg8lbHrcrFYkrnO9vHYQIeHbKKjqdepNgJYP8s55Hk9oakBrcuet2R7Y2oRrAKy
 3N+q9veZ3I8HocNfzLEy4Xss4C2MbIF1/HH2xqSCEzwGRpNEYZCjOe6zYa7IUxk0P0Ko
 PMROpiU/VtAnmDw3+JacXejaRRZTghE5gbAT3Z/tWE2YNxG4C2b/Nii5VDs4OMcaGQ+M
 ndUeymnIQFVMffDO8FxD27N/FsG7oovTigPN6SSqcLw13Li/AnTPWnrjcyhwmuDi+pMm
 dgNpJ3kJHiLwveGXCAtd3W66xDblifswyrzXJvcPp6vcvf5JwAeuN4WqClAF/XJfL931 4w== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2n384uhwpb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Oct 2018 02:16:06 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9J2G5e5006162
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Oct 2018 02:16:05 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9J2G51E024241;
        Fri, 19 Oct 2018 02:16:05 GMT
Received: from [10.159.250.170] (/10.159.250.170)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 18 Oct 2018 19:16:05 -0700
Subject: Re: [PATCH V2] xen-swiotlb: use actually allocated size on check
 physical continuous
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     John Sobecki <john.sobecki@oracle.com>,
        "DONGLI.ZHANG" <dongli.zhang@oracle.com>, konrad@kernel.org,
        Christoph Helwig <hch@lst.de>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <0453c762-1f8b-079f-5fdf-548e90909318@oracle.com>
 <20181018235219.GA36047@konrads-mbp.lan>
From:   Joe Jin <joe.jin@oracle.com>
Message-ID: <e476c3e8-d501-c5c6-d389-8b0b33adf4b1@oracle.com>
Date:   Thu, 18 Oct 2018 19:16:04 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181018235219.GA36047@konrads-mbp.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9050 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810190018
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/18 4:52 PM, Konrad Rzeszutek Wilk wrote:
> On Tue, Oct 16, 2018 at 03:21:16PM -0700, Joe Jin wrote:
>> xen_swiotlb_{alloc,free}_coherent() allocate/free memory by order,
>> but passed required size to range_straddles_page_boundary(),
>> when first pages are physical continuous,
>> range_straddles_page_boundary() returned true, then did not
>> exchanged memory with Xen, later on free memory, it tried to
>> exchanged non-contiguous memory with Xen, then kernel panic.
> 
> I have a hard time understanding the commit message.
> 
> I think you mean to say:
> 
> xen_swiotlb_{alloc,free}_coherent() allocate/free memory based on the
> order of the pages and not size argument (bytes). This is inconsistent with
> range_straddles_page_boundary and memset which use the 'size' value,
> which may lead to not exchanging memory with Xen (range_straddles_page_boundary()
> returned true). And then the call to xen_swiotlb_free_coherent() would
> actually try to exchange the memory with Xen, leading to the kernel
> hitting an BUG (as the hypercall returned an error).

Sorry for the confusing, yes you right.

BTW: panic triggered by xen_remap_exchanged_ptes()->xen_mc_issue().

Panic calltrace as below:

 [ 1129.150648] WARNING: CPU: 1 PID: 21001 at arch/x86/xen/multicalls.c:129
xen_mc_flush+0x1ce/0x1e0()
[ 1129.150653] Modules linked in: ocfs2 mptctl mptbase xen_netback
xen_blkback xen_gntalloc xen_gntdev xen_evtchn xenfs xen_privcmd ocfs2_dlmfs
ocfs2_stack_o2cb ocfs2_dlm ocfs2_nodemanager ocfs2_stackglue configfs bnx2fc
fcoe libfcoe libfc sunrpc 8021q mrp garp bridge stp llc bonding
dm_round_robin dm_multipath iTCO_wdt iTCO_vendor_support pcspkr shpchp
sb_edac edac_core i2c_i801 i2c_core cdc_ether usbnet mii lpc_ich mfd_core
ioatdma sg ipmi_devintf ipmi_si ipmi_msghandler ext4 jbd2 mbcache2 sd_mod
usb_storage ahci libahci megaraid_sas ixgbe dca ptp pps_core vxlan udp_tunnel
ip6_udp_tunnel qla2xxx scsi_transport_fc crc32c_intel be2iscsi bnx2i cnic uio
cxgb4i cxgb4 cxgb3i libcxgbi ipv6 cxgb3 mdio libiscsi_tcp qla4xxx
iscsi_boot_sysfs libiscsi scsi_transport_iscsi wmi dm_mirror dm_region_hash
dm_log dm_mod
[ 1129.150719]
[ 1129.150722] CPU: 1 PID: 21001 Comm: blkid Tainted: G        W        
4.1.12-124.16.3.el6uek.x86_64 #2
[ 1129.150723] Hardware name: Oracle Corporation ORACLE SERVER
X5-2/ASM,MOTHERBOARD,1U, BIOS 30130400 02/08/2018
[ 1129.150727]  0000000000000000 ffff8803ec7c3c78 ffffffff816e52a3
0000000000000000
[ 1129.150732]  ffffffff819bc5c3 ffff8803ec7c3cb8 ffffffff8108481a
ffff8803ec7c3d18
[ 1129.150735]  ffff8804a6a4d2c0 0000000000000003 ffff8804994df800
0000000000000001
[ 1129.150740] Call Trace:
[ 1129.150746]  [<ffffffff816e52a3>] dump_stack+0x63/0x81
[ 1129.150753]  [<ffffffff8108481a>] warn_slowpath_common+0x8a/0xc0
[ 1129.150756]  [<ffffffff8108490a>] warn_slowpath_null+0x1a/0x20
[ 1129.150759]  [<ffffffff8100559e>] xen_mc_flush+0x1ce/0x1e0
[ 1129.150764]  [<ffffffff81007af9>] __xen_pgd_unpin+0x109/0x250
[ 1129.150767]  [<ffffffff81007db7>] xen_exit_mmap+0x177/0x2a0
[ 1129.150770]  [<ffffffff811c3628>] exit_mmap+0x48/0x160
[ 1129.150776]  [<ffffffff8112c68c>] ? __audit_free+0x1cc/0x220
[ 1129.150784]  [<ffffffff811e725e>] ? kfree+0x16e/0x180
[ 1129.150787]  [<ffffffff81081cf3>] mmput+0x63/0x100
[ 1129.150790]  [<ffffffff81087263>] do_exit+0x343/0xa90
[ 1129.150793]  [<ffffffff8112c794>] ? __audit_syscall_entry+0xb4/0x110
[ 1129.150796]  [<ffffffff81025a2c>] ? do_audit_syscall_entry+0x6c/0x70
[ 1129.150799]  [<ffffffff81087a45>] do_group_exit+0x45/0xb0
[ 1129.150805]  [<ffffffff81087ac4>] SyS_exit_group+0x14/0x20
[ 1129.150807]  [<ffffffff816edc5c>] system_call_fastpath+0x18/0xd6
[ 1129.150810] ---[ end trace 7aec0081e2a07193 ]---

Do you think the patch fine or no? if yes I'll reorg patch description
and resend it.

Thanks,
Joe

> 
> This patch fixes it by making the 'size' variable be of the same size
> as the amount of memory allocated.
> 
> I checked it as such..
>>
>> Signed-off-by: Joe Jin <joe.jin@oracle.com>
>> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>> Cc: Christoph Helwig <hch@lst.de>
>> Cc: Dongli Zhang <dongli.zhang@oracle.com>
>> Cc: John Sobecki <john.sobecki@oracle.com>
>>
>> ---
>>  drivers/xen/swiotlb-xen.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
>> index a6f9ba85dc4b..aa081f806728 100644
>> --- a/drivers/xen/swiotlb-xen.c
>> +++ b/drivers/xen/swiotlb-xen.c
>> @@ -303,6 +303,9 @@ xen_swiotlb_alloc_coherent(struct device *hwdev, size_t size,
>>  	*/
>>  	flags &= ~(__GFP_DMA | __GFP_HIGHMEM);
>>  
>> +	/* Convert the size to actually allocated. */
>> +	size = 1UL << (order + XEN_PAGE_SHIFT);
>> +
>>  	/* On ARM this function returns an ioremap'ped virtual address for
>>  	 * which virt_to_phys doesn't return the corresponding physical
>>  	 * address. In fact on ARM virt_to_phys only works for kernel direct
>> @@ -351,6 +354,9 @@ xen_swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
>>  	 * physical address */
>>  	phys = xen_bus_to_phys(dev_addr);
>>  
>> +	/* Convert the size to actually allocated. */
>> +	size = 1UL << (order + XEN_PAGE_SHIFT);
>> +
>>  	if (((dev_addr + size - 1 <= dma_mask)) ||
>>  	    range_straddles_page_boundary(phys, size))
>>  		xen_destroy_contiguous_region(phys, order);
>> -- 
>> 2.15.2 (Apple Git-101.1)
>>
>>


-- 
Oracle <http://www.oracle.com>
Joe Jin | Software Development Director 
ORACLE | Linux and Virtualization
500 Oracle Parkway Redwood City, CA US 94065
