Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751314AbeDDIZQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 04:25:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55428 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751167AbeDDIZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 04:25:14 -0400
Subject: Re: [PATCH v9 09/24] mm: protect mremap() against SPF hanlder
To: David Rientjes <rientjes@google.com>
Cc: paulmck@linux.vnet.ibm.com, peterz@infradead.org,
        akpm@linux-foundation.org, kirill@shutemov.name, ak@linux.intel.com,
        mhocko@kernel.org, dave@stgolabs.net, jack@suse.cz,
        Matthew Wilcox <willy@infradead.org>, benh@kernel.crashing.org,
        mpe@ellerman.id.au, paulus@samba.org,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        hpa@zytor.com, Will Deacon <will.deacon@arm.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>, kemi.wang@intel.com,
        sergey.senozhatsky.work@gmail.com,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        haren@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com,
        npiggin@gmail.com, bsingharora@gmail.com,
        Tim Chen <tim.c.chen@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org
References: <1520963994-28477-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1520963994-28477-10-git-send-email-ldufour@linux.vnet.ibm.com>
 <alpine.DEB.2.20.1803271500540.43106@chino.kir.corp.google.com>
 <1fe7529a-947c-fdb2-12d2-b38bdd41bb04@linux.vnet.ibm.com>
 <alpine.DEB.2.20.1803281419460.167685@chino.kir.corp.google.com>
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Wed, 4 Apr 2018 10:24:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1803281419460.167685@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18040408-0044-0000-0000-0000054343F6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040408-0045-0000-0000-000028835969
Message-Id: <e9602fb6-7f74-58e0-2567-9c84b63e3383@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-04_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804040089
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/03/2018 23:21, David Rientjes wrote:
> On Wed, 28 Mar 2018, Laurent Dufour wrote:
> 
>>>> @@ -326,7 +336,10 @@ static unsigned long move_vma(struct vm_area_struct *vma,
>>>>  		mremap_userfaultfd_prep(new_vma, uf);
>>>>  		arch_remap(mm, old_addr, old_addr + old_len,
>>>>  			   new_addr, new_addr + new_len);
>>>> +		if (vma != new_vma)
>>>> +			vm_raw_write_end(vma);
>>>>  	}
>>>> +	vm_raw_write_end(new_vma);
>>>
>>> Just do
>>>
>>> vm_raw_write_end(vma);
>>> vm_raw_write_end(new_vma);
>>>
>>> here.
>>
>> Are you sure ? we can have vma = new_vma done if (unlikely(err))
>>
> 
> Sorry, what I meant was do
> 
> if (vma != new_vma)
> 	vm_raw_write_end(vma);
> vm_raw_write_end(new_vma);
> 
> after the conditional.  Having the locking unnecessarily embedded in the 
> conditional has been an issue in the past with other areas of core code, 
> unless you have a strong reason for it.

Unfortunately, I can't see how doing this in another way since vma = new_vma is
done in the error branch.
So releasing the VMAs outside of the conditional may lead to miss 'vma' if the
error branch is taken.

Here is the code snippet as a reminder:

	new_vma = copy_vma(&vma, new_addr, new_len, new_pgoff,
			   &need_rmap_locks);
	[...]
	if (vma != new_vma)
		vm_raw_write_begin(vma);
	[...]
	if (unlikely(err)) {
		[...]
		if (vma != new_vma)
			vm_raw_write_end(vma);
		vma = new_vma; <<<< here we lost reference to vma
		[...]
	} else {
		[...]
		if (vma != new_vma)
			vm_raw_write_end(vma);
	}
	vm_raw_write_end(new_vma);
