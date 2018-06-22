Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD23C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32E1B245AC
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:17:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32E1B245AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934162AbeFVQR4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 12:17:56 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:14706 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933995AbeFVQRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 12:17:55 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 41C3dC4b4pz9tvr7;
        Fri, 22 Jun 2018 18:17:51 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 8ify1mQfBOqm; Fri, 22 Jun 2018 18:17:51 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 41C3dC42HFz9tvr6;
        Fri, 22 Jun 2018 18:17:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E87268B96A;
        Fri, 22 Jun 2018 18:17:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id BUzApBpeJIcX; Fri, 22 Jun 2018 18:17:53 +0200 (CEST)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.35])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9B4A28B964;
        Fri, 22 Jun 2018 18:17:53 +0200 (CEST)
Subject: Re: [PATCH] powerpc/mm: fix always true/false warning in slice.c
To:     Mathieu Malaterre <malat@debian.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <63b696ab7be8b941fa1e1589f28260320d12a32a.1529589640.git.christophe.leroy@c-s.fr>
 <CA+7wUszwUKjdQzdekaE-CJ1_d9JR9HCz5od1L390EMpRbfTfng@mail.gmail.com>
From:   Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <70915836-28d4-ccfb-01cc-e0c2a0251350@c-s.fr>
Date:   Fri, 22 Jun 2018 18:17:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CA+7wUszwUKjdQzdekaE-CJ1_d9JR9HCz5od1L390EMpRbfTfng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 22/06/2018 à 16:55, Mathieu Malaterre a écrit :
> On Fri, Jun 22, 2018 at 3:49 PM Christophe Leroy
> <christophe.leroy@c-s.fr> wrote:
>>
>> This patch fixes the following warnings (obtained with make W=1).
>>
>> arch/powerpc/mm/slice.c: In function 'slice_range_to_mask':
>> arch/powerpc/mm/slice.c:73:12: error: comparison is always true due to limited range of data type [-Werror=type-limits]
>>    if (start < SLICE_LOW_TOP) {
>>              ^
>> arch/powerpc/mm/slice.c:81:20: error: comparison is always false due to limited range of data type [-Werror=type-limits]
>>    if ((start + len) > SLICE_LOW_TOP) {
>>                      ^
>> arch/powerpc/mm/slice.c: In function 'slice_mask_for_free':
>> arch/powerpc/mm/slice.c:136:17: error: comparison is always true due to limited range of data type [-Werror=type-limits]
>>    if (high_limit <= SLICE_LOW_TOP)
>>                   ^
>> arch/powerpc/mm/slice.c: In function 'slice_check_range_fits':
>> arch/powerpc/mm/slice.c:185:12: error: comparison is always true due to limited range of data type [-Werror=type-limits]
>>    if (start < SLICE_LOW_TOP) {
>>              ^
>> arch/powerpc/mm/slice.c:195:39: error: comparison is always false due to limited range of data type [-Werror=type-limits]
>>    if (SLICE_NUM_HIGH && ((start + len) > SLICE_LOW_TOP)) {
>>                                         ^
>> arch/powerpc/mm/slice.c: In function 'slice_scan_available':
>> arch/powerpc/mm/slice.c:306:11: error: comparison is always true due to limited range of data type [-Werror=type-limits]
>>    if (addr < SLICE_LOW_TOP) {
>>             ^
>> arch/powerpc/mm/slice.c: In function 'get_slice_psize':
>> arch/powerpc/mm/slice.c:709:11: error: comparison is always true due to limited range of data type [-Werror=type-limits]
>>    if (addr < SLICE_LOW_TOP) {
>>             ^
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>   arch/powerpc/mm/slice.c | 21 ++++++++++++++-------
>>   1 file changed, 14 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
>> index 9530c6db406a..17c57760e06c 100644
>> --- a/arch/powerpc/mm/slice.c
>> +++ b/arch/powerpc/mm/slice.c
>> @@ -62,6 +62,13 @@ static void slice_print_mask(const char *label, const struct slice_mask *mask) {
>>
>>   #endif
>>
>> +static inline bool slice_addr_is_low(unsigned long addr)
>> +{
>> +       u64 tmp = (u64)addr;
>> +
>> +       return tmp < SLICE_LOW_TOP;
>> +}
>> +
>>   static void slice_range_to_mask(unsigned long start, unsigned long len,
>>                                  struct slice_mask *ret)
>>   {
>> @@ -71,7 +78,7 @@ static void slice_range_to_mask(unsigned long start, unsigned long len,
>>          if (SLICE_NUM_HIGH)
>>                  bitmap_zero(ret->high_slices, SLICE_NUM_HIGH);
>>
>> -       if (start < SLICE_LOW_TOP) {
>> +       if (slice_addr_is_low(start)) {
>>                  unsigned long mend = min(end,
>>                                           (unsigned long)(SLICE_LOW_TOP - 1));
>>
>> @@ -79,7 +86,7 @@ static void slice_range_to_mask(unsigned long start, unsigned long len,
>>                          - (1u << GET_LOW_SLICE_INDEX(start));
>>          }
>>
>> -       if ((start + len) > SLICE_LOW_TOP) {
>> +       if (!slice_addr_is_low(end)) {
>>                  unsigned long start_index = GET_HIGH_SLICE_INDEX(start);
>>                  unsigned long align_end = ALIGN(end, (1UL << SLICE_HIGH_SHIFT));
>>                  unsigned long count = GET_HIGH_SLICE_INDEX(align_end) - start_index;
>> @@ -134,7 +141,7 @@ static void slice_mask_for_free(struct mm_struct *mm, struct slice_mask *ret,
>>                  if (!slice_low_has_vma(mm, i))
>>                          ret->low_slices |= 1u << i;
>>
>> -       if (high_limit <= SLICE_LOW_TOP)
>> +       if (slice_addr_is_low(high_limit - 1))
> 
> Is high_limit ever going to be 0 ?

See slice_get_unmapped_area(), high_limit will never be 0.

Christophe

> 
>>                  return;
>>
>>          for (i = 0; i < GET_HIGH_SLICE_INDEX(high_limit); i++)
>> @@ -183,7 +190,7 @@ static bool slice_check_range_fits(struct mm_struct *mm,
>>          unsigned long end = start + len - 1;
>>          u64 low_slices = 0;
>>
>> -       if (start < SLICE_LOW_TOP) {
>> +       if (slice_addr_is_low(start)) {
>>                  unsigned long mend = min(end,
>>                                           (unsigned long)(SLICE_LOW_TOP - 1));
>>
>> @@ -193,7 +200,7 @@ static bool slice_check_range_fits(struct mm_struct *mm,
>>          if ((low_slices & available->low_slices) != low_slices)
>>                  return false;
>>
>> -       if (SLICE_NUM_HIGH && ((start + len) > SLICE_LOW_TOP)) {
>> +       if (SLICE_NUM_HIGH && !slice_addr_is_low(end)) {
>>                  unsigned long start_index = GET_HIGH_SLICE_INDEX(start);
>>                  unsigned long align_end = ALIGN(end, (1UL << SLICE_HIGH_SHIFT));
>>                  unsigned long count = GET_HIGH_SLICE_INDEX(align_end) - start_index;
>> @@ -304,7 +311,7 @@ static bool slice_scan_available(unsigned long addr,
>>                                   int end, unsigned long *boundary_addr)
>>   {
>>          unsigned long slice;
>> -       if (addr < SLICE_LOW_TOP) {
>> +       if (slice_addr_is_low(addr)) {
>>                  slice = GET_LOW_SLICE_INDEX(addr);
>>                  *boundary_addr = (slice + end) << SLICE_LOW_SHIFT;
>>                  return !!(available->low_slices & (1u << slice));
>> @@ -707,7 +714,7 @@ unsigned int get_slice_psize(struct mm_struct *mm, unsigned long addr)
>>
>>          VM_BUG_ON(radix_enabled());
>>
>> -       if (addr < SLICE_LOW_TOP) {
>> +       if (slice_addr_is_low(addr)) {
>>                  psizes = mm->context.low_slices_psize;
>>                  index = GET_LOW_SLICE_INDEX(addr);
>>          } else {
>> --
>> 2.13.3
>>
