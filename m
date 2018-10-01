Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA84C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 23:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED8912084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 23:23:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED8912084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbeJBGDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 02:03:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52198 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725936AbeJBGDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 02:03:44 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w91NIU74123477
        for <linux-kernel@vger.kernel.org>; Mon, 1 Oct 2018 19:23:32 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2musm8yb4x-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 19:23:32 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tyreld@linux.vnet.ibm.com>;
        Mon, 1 Oct 2018 17:23:31 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 1 Oct 2018 17:23:27 -0600
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w91NNRDZ27590808
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 1 Oct 2018 16:23:27 -0700
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0488778066;
        Mon,  1 Oct 2018 17:23:27 -0600 (MDT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E5C578064;
        Mon,  1 Oct 2018 17:23:23 -0600 (MDT)
Received: from oc6857751186.ibm.com (unknown [9.85.143.166])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  1 Oct 2018 17:23:23 -0600 (MDT)
Subject: Re: [PATCH] migration/mm: Add WARN_ON to try_offline_node
To:     Michal Hocko <mhocko@kernel.org>,
        Michael Bringmann <mwb@linux.vnet.ibm.com>
Cc:     Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Mathieu Malaterre <malat@debian.org>,
        linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>, linux-mm@kvack.org,
        Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
        Juliet Kim <minkim@us.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
        Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>,
        linuxppc-dev@lists.ozlabs.org,
        Dan Williams <dan.j.williams@intel.com>,
        Oscar Salvador <osalvador@suse.de>
References: <20181001185616.11427.35521.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com>
 <20181001202724.GL18290@dhcp22.suse.cz>
From:   Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date:   Mon, 1 Oct 2018 16:23:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181001202724.GL18290@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18100123-0036-0000-0000-00000A425FFB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009805; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01096517; UDB=6.00566995; IPR=6.00876559;
 MB=3.00023581; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-01 23:23:31
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100123-0037-0000-0000-00004922A2C1
Message-Id: <75acdad4-f0f4-f9c6-8a5c-3df44d4882cf@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-01_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=905 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810010222
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/01/2018 01:27 PM, Michal Hocko wrote:
> On Mon 01-10-18 13:56:25, Michael Bringmann wrote:
>> In some LPAR migration scenarios, device-tree modifications are
>> made to the affinity of the memory in the system.  For instance,
>> it may occur that memory is installed to nodes 0,3 on a source
>> system, and to nodes 0,2 on a target system.  Node 2 may not
>> have been initialized/allocated on the target system.
>>
>> After migration, if a RTAS PRRN memory remove is made to a
>> memory block that was in node 3 on the source system, then
>> try_offline_node tries to remove it from node 2 on the target.
>> The NODE_DATA(2) block would not be initialized on the target,
>> and there is no validation check in the current code to prevent
>> the use of a NULL pointer.
> 
> I am not familiar with ppc and the above doesn't really help me
> much. Sorry about that. But from the above it is not clear to me whether
> it is the caller which does something unexpected or the hotplug code
> being not robust enough. From your changelog I would suggest the later
> but why don't we see the same problem for other archs? Is this a problem
> of unrolling a partial failure?
> 
> dlpar_remove_lmb does the following
> 
> 	nid = memory_add_physaddr_to_nid(lmb->base_addr);
> 
> 	remove_memory(nid, lmb->base_addr, block_sz);
> 
> 	/* Update memory regions for memory remove */
> 	memblock_remove(lmb->base_addr, block_sz);
> 
> 	dlpar_remove_device_tree_lmb(lmb);
> 
> Is the whole operation correct when remove_memory simply backs off
> silently. Why don't we have to care about memblock resp
> dlpar_remove_device_tree_lmb parts? In other words how come the physical
> memory range is valid while the node association is not?
> 

I guess with respect to my previous reply that patch in conjunction with this patch set as well?

https://lore.kernel.org/linuxppc-dev/20181001125846.2676.89826.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com/T/#t

-Tyrel

