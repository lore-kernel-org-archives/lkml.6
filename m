Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933064AbeEWNqE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 09:46:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40764 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932941AbeEWNqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 09:46:03 -0400
Subject: Re: [PATCH 2/2] mm: do not warn on offline nodes unless the specific
 node is explicitly requested
To: Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20180523125555.30039-1-mhocko@kernel.org>
 <20180523125555.30039-3-mhocko@kernel.org>
Cc: Oscar Salvador <osalvador@techadventures.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Reza Arbab <arbab@linux.vnet.ibm.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Wed, 23 May 2018 19:15:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20180523125555.30039-3-mhocko@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18052313-0012-0000-0000-000005D9C71C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052313-0013-0000-0000-0000195711D7
Message-Id: <11e26a4e-552e-b1dc-316e-ce3e92973556@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-23_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805230140
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/23/2018 06:25 PM, Michal Hocko wrote:
> when adding memory to a node that is currently offline.
> 
> The VM_WARN_ON is just too loud without a good reason. In this
> particular case we are doing
> 	alloc_pages_node(node, GFP_KERNEL|__GFP_RETRY_MAYFAIL|__GFP_NOWARN, order)
> 
> so we do not insist on allocating from the given node (it is more a
> hint) so we can fall back to any other populated node and moreover we
> explicitly ask to not warn for the allocation failure.
> 
> Soften the warning only to cases when somebody asks for the given node
> explicitly by __GFP_THISNODE.

node hint passed here eventually goes into __alloc_pages_nodemask()
function which then picks up the applicable zonelist irrespective of
the GFP flag __GFP_THISNODE. Though we can go into zones of other
nodes if the present node (whose zonelist got picked up) does not
have any memory in it's zones. So warning here might not be without
any reason. But yes, if the request has __GFP_NOWARN it makes sense
not to print any warning.
