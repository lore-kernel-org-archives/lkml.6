Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754100AbeDMMCG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 08:02:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44404 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751421AbeDMMCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 08:02:04 -0400
Subject: Re: [PATCH 2/2] mm: vmalloc: Pass proper vm_start into debugobjects
To: Chintan Pandya <cpandya@codeaurora.org>, vbabka@suse.cz,
        labbott@redhat.com, catalin.marinas@arm.com, hannes@cmpxchg.org,
        f.fainelli@gmail.com, xieyisheng1@huawei.com,
        ard.biesheuvel@linaro.org, richard.weiyang@gmail.com,
        byungchul.park@lge.com
References: <1523619234-17635-1-git-send-email-cpandya@codeaurora.org>
 <1523619234-17635-3-git-send-email-cpandya@codeaurora.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Fri, 13 Apr 2018 17:31:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <1523619234-17635-3-git-send-email-cpandya@codeaurora.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18041312-0020-0000-0000-000004118643
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041312-0021-0000-0000-000042A5B8BC
Message-Id: <ee1e7036-ecdf-0f5b-f460-0d71b4a38dd7@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-13_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804130113
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/13/2018 05:03 PM, Chintan Pandya wrote:
> Client can call vunmap with some intermediate 'addr'
> which may not be the start of the VM area. Entire
> unmap code works with vm->vm_start which is proper
> but debug object API is called with 'addr'. This
> could be a problem within debug objects.
> 
> Pass proper start address into debug object API.
> 
> Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
> ---
>  mm/vmalloc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 9ff21a1..28034c55 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1526,8 +1526,8 @@ static void __vunmap(const void *addr, int deallocate_pages)
>  		return;
>  	}
>  
> -	debug_check_no_locks_freed(addr, get_vm_area_size(area));
> -	debug_check_no_obj_freed(addr, get_vm_area_size(area));
> +	debug_check_no_locks_freed(area->addr, get_vm_area_size(area));
> +	debug_check_no_obj_freed(area->addr, get_vm_area_size(area));

This kind of makes sense to me but I am not sure. We also have another
instance of this inside the function vm_unmap_ram() where we call for
debug on locks without even finding the vmap_area first. But it is true
that in both these functions the vmap_area gets freed eventually. Hence
the entire mapping [va->va_start --> va->va_end] gets unmapped. Sounds
like these debug functions should have the entire range as argument.
But I am not sure and will seek Michal's input on this.
