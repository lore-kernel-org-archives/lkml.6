Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751689AbeBYL5d (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 06:57:33 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47966 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751634AbeBYL53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 06:57:29 -0500
Subject: Re: [PATCH v12 1/3] mm, powerpc, x86: define VM_PKEY_BITx bits if
 CONFIG_ARCH_HAS_PKEYS is enabled
To: Ram Pai <linuxram@us.ibm.com>, kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, mpe@ellerman.id.au, mingo@redhat.com,
        akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, dave.hansen@intel.com,
        benh@kernel.crashing.org, paulus@samba.org,
        khandual@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
        mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com,
        corbet@lwn.net, arnd@arndb.de, fweimer@redhat.com, msuchanek@suse.com
References: <1519257138-23797-2-git-send-email-linuxram@us.ibm.com>
 <201802231528.snWZIspR%fengguang.wu@intel.com>
 <20180224010511.GK5559@ram.oc3035372033.ibm.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Sun, 25 Feb 2018 17:27:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180224010511.GK5559@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18022511-0024-0000-0000-000017FE29E0
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008594; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00994854; UDB=6.00505629; IPR=6.00774186;
 MB=3.00019732; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-25 11:57:25
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022511-0025-0000-0000-00004EDE91DC
Message-Id: <43082fe4-a6e4-2468-0069-4fbc53418c79@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-25_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802250159
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/24/2018 06:35 AM, Ram Pai wrote:
> On Fri, Feb 23, 2018 at 03:11:45PM +0800, kbuild test robot wrote:
>> Hi Ram,
>>
>> Thank you for the patch! Yet something to improve:
>>
>> [auto build test ERROR on linus/master]
>> [also build test ERROR on v4.16-rc2 next-20180222]
>> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>>
>>          chmod +x ~/bin/make.cross
> ...snip..
>>          # save the attached .config to linux build tree
>>          make.cross ARCH=powerpc
>>
>> Note: the linux-review/Ram-Pai/mm-x86-powerpc-Enhancements-to-Memory-Protection-Keys/20180223-042743 HEAD c5692bca45543c242ffca15c811923e4c548ed19 builds fine.
>>        It only hurts bisectibility.
> 
> oops, it broke git-bisect on powerpc :-(
> The following change will fix it. This should nail it down.
> 
> diff --git a/arch/powerpc/include/asm/pkeys.h
> b/arch/powerpc/include/asm/pkeys.h
> index 0409c80..0b3b669 100644
> --- a/arch/powerpc/include/asm/pkeys.h
> +++ b/arch/powerpc/include/asm/pkeys.h
> @@ -25,6 +25,7 @@
>   # define VM_PKEY_BIT1  VM_HIGH_ARCH_1
>   # define VM_PKEY_BIT2  VM_HIGH_ARCH_2
>   # define VM_PKEY_BIT3  VM_HIGH_ARCH_3
>   # define VM_PKEY_BIT4  VM_HIGH_ARCH_4
> +#elif !defined(VM_PKEY_BIT4)
> +# define VM_PKEY_BIT4  VM_HIGH_ARCH_4
> #endif
> 

Why don't you remove this powerpc definition completely in this patch? 
Also move that comment above #define. The comments are not specific to
BIT1

@@ -231,9 +231,10 @@ extern int overcommit_kbytes_handler(struct 
ctl_table *, int, void __user *,
  #ifdef CONFIG_ARCH_HAS_PKEYS
  # define VM_PKEY_SHIFT	VM_HIGH_ARCH_BIT_0
  # define VM_PKEY_BIT0	VM_HIGH_ARCH_0	/* A protection key is a 4-bit 
value */
-# define VM_PKEY_BIT1	VM_HIGH_ARCH_1
+# define VM_PKEY_BIT1	VM_HIGH_ARCH_1	/* on x86 and 5-bit value on ppc64 
   */
  # define VM_PKEY_BIT2	VM_HIGH_ARCH_2
  # define VM_PKEY_BIT3	VM_HIGH_ARCH_3
+# define VM_PKEY_BIT4	VM_HIGH_ARCH_4
  #endif /* CONFIG_ARCH_HAS_PKEYS */



-aneesh
