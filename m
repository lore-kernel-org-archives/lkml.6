Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752491AbeEORmy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 13:42:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42418 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751099AbeEORmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 13:42:52 -0400
Date: Tue, 15 May 2018 10:44:16 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nitzan Carmi <nitzanc@mellanox.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Keith Busch <keith.busch@intel.com>
Subject: Re: linux-next: manual merge of the rcu tree with Linus' tree
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180514134636.61831bcc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514134636.61831bcc@canb.auug.org.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18051517-0036-0000-0000-000002F52D3C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009030; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01032747; UDB=6.00528002; IPR=6.00811878;
 MB=3.00021129; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-15 17:42:47
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051517-0037-0000-0000-000044585960
Message-Id: <20180515174416.GJ26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-15_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805150176
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 01:46:36PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the rcu tree got a conflict in:
> 
>   drivers/nvme/host/core.c
> 
> between commit:
> 
>   12d9f07022dc ("nvme: fix use-after-free in nvme_free_ns_head")
> 
> from Linus' tree and commit:
> 
>   d9cf21bae6cf ("nvme: Avoid flush dependency in delete controller flow")
> 
> from the rcu tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Thank you, Stephen!!!

							Thanx, Paul

> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc drivers/nvme/host/core.c
> index 99b857e5a7a9,c3cea8a29843..000000000000
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@@ -351,8 -349,7 +351,8 @@@ static void nvme_free_ns_head(struct kr
>   	nvme_mpath_remove_disk(head);
>   	ida_simple_remove(&head->subsys->ns_ida, head->instance);
>   	list_del_init(&head->entry);
> - 	cleanup_srcu_struct(&head->srcu);
> + 	cleanup_srcu_struct_quiesced(&head->srcu);
>  +	nvme_put_subsystem(head->subsys);
>   	kfree(head);
>   }
>   
