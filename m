Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752369AbeB0HUW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 02:20:22 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56636 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752153AbeB0HUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 02:20:17 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
        Nicholas Piggin <npiggin@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC REBASED 3/5] powerpc/mm/slice: implement slice_check_range_fits
In-Reply-To: <caa9d52e0a8ef15719bafe8002a4ad2dc359c634.1518382747.git.christophe.leroy@c-s.fr>
References: <02a62db83282b5ef3e0e8281fdc46fa91beffc86.1518382747.git.christophe.leroy@c-s.fr> <caa9d52e0a8ef15719bafe8002a4ad2dc359c634.1518382747.git.christophe.leroy@c-s.fr>
Date: Tue, 27 Feb 2018 12:50:08 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 18022707-0016-0000-0000-0000052A3DDC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022707-0017-0000-0000-0000286668DF
Message-Id: <87k1uy7vbr.fsf@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-27_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802270086
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:
 +	if ((start + len) > SLICE_LOW_TOP) {
> +		unsigned long start_index = GET_HIGH_SLICE_INDEX(start);
> +		unsigned long align_end = ALIGN(end, (1UL << SLICE_HIGH_SHIFT));
> +		unsigned long count = GET_HIGH_SLICE_INDEX(align_end) - start_index;
> +		unsigned long i;
>  
> -	slice_bitmap_and(result, mask->high_slices, available->high_slices,
> -			 slice_count);
> +		for (i = start_index; i < start_index + count; i++) {
> +			if (!test_bit(i, available->high_slices))
> +				return false;
> +		}
> +	}

why not bitmap_equal here instead of test_bit in loop?
>  
> -	return (mask->low_slices & available->low_slices) == mask->low_slices &&
> -		slice_bitmap_equal(result, mask->high_slices, slice_count);
> +	return true;
>  }

-aneesh
