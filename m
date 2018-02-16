Return-Path: <borntraeger@de.ibm.com>
X-Google-Smtp-Source: AH8x2266D1yFjTcpOFigovOGbnd42FwecZvixjCZLaTJpejPkDybcyqfUdRi0KBwf1IN00Xz1GH4
ARC-Seal: i=1; a=rsa-sha256; t=1518771316; cv=none;
        d=google.com; s=arc-20160816;
        b=d/G3f6uIZvWauhRxHRBd/HRDFUUxZ3Dg6Ru2+gF/V98ONE2Yxh/5XAuSQalWp9jpCJ
         Ve0I0bkj4wFich+fSoQm/mtv9pvqBqoFjHbCFRGo+uyiGCnkugrqznv75omtuaIfQax+
         GerEubC0T1EXTNiiWvmjDqXbf+cKYydv4uf0EQmT6jG3I/06Or8a+gkszKzbk4v1Z4xC
         nnUIr0qQZDQOc8Xym3oTUedSIgT/18XIgr1IQMclG7YebDuQQB6mOzjKT8NrctUl5g5w
         dFq9Qpzc5n+PoPpCABSHp3pNiioO20sKz4NtF+hkdWekw+yO/M2eLW74q2HmKPS751Op
         KlaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:content-language:in-reply-to
         :mime-version:user-agent:date:from:references:cc:to:subject
         :arc-authentication-results;
        bh=n60i4FxhGFDkIn/JNKibTsqBnfmR+Mynj3ULW7HpAYw=;
        b=MRSUAKHrz7lb8prQeihTm8IortoCc6VFn6z1RZVtqeuxqIECcQV0GwLVNUZE7auqSa
         YL26y1S83EiI9Y+FWNYSDzsx961BM1Q19XimzQYmgPPkPXmtfY0ZNjx3do+UZoI4ZKNW
         1Xs2/o2/HGM3a+hL0veMVe0RcMYdsBPcdzf+qmxlNgZWTeG2kAUIRTUk6clmLDVKe7w7
         zd1Xf8VVBcvHu4iwGqpXl7u8egltK9RHu6+rNuNL31/V8A/6o7cIqQh/90lGGTuwI56l
         P6g499ljkVOwHyMoGi3s6/P8tRri0cYFb24KVxFUjErEyhfULOrhSoBa7dEsoA6guBb9
         kEkw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of borntraeger@de.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=borntraeger@de.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of borntraeger@de.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=borntraeger@de.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH v6 02/13] array_index_nospec: sanitize speculative array
 de-references
To: Dan Williams <dan.j.williams@intel.com>, tglx@linutronix.de,
        mingo@kernel.org
Cc: linux-arch@vger.kernel.org, Cyril Novikov <cnovikov@lynx.com>,
        kernel-hardening@lists.openwall.com,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, gregkh@linuxfoundation.org,
        "H. Peter Anvin" <hpa@zytor.com>, torvalds@linux-foundation.org,
        alan@linux.intel.com
References: <151727412964.33451.17213780323040673404.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151727414229.33451.18411580953862676575.stgit@dwillia2-desk3.amr.corp.intel.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 16 Feb 2018 09:55:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <151727414229.33451.18411580953862676575.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18021608-0008-0000-0000-000004D0543F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021608-0009-0000-0000-00001E635789
Message-Id: <366bb116-e375-458c-2b63-1b26b4c8bdac@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-16_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802160107
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590977823995808037?=
X-GMAIL-MSGID: =?utf-8?q?1592547152638022143?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 01/30/2018 02:02 AM, Dan Williams wrote:
> array_index_nospec() is proposed as a generic mechanism to mitigate
> against Spectre-variant-1 attacks, i.e. an attack that bypasses boundary
> checks via speculative execution. The array_index_nospec()
> implementation is expected to be safe for current generation CPUs across
> multiple architectures (ARM, x86).
> 
> Based on an original implementation by Linus Torvalds, tweaked to remove
> speculative flows by Alexei Starovoitov, and tweaked again by Linus to
> introduce an x86 assembly implementation for the mask generation.
> 
> Co-developed-by: Linus Torvalds <torvalds@linux-foundation.org>
> Co-developed-by: Alexei Starovoitov <ast@kernel.org>
> Suggested-by: Cyril Novikov <cnovikov@lynx.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  include/linux/nospec.h |   72 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 include/linux/nospec.h
> 
> diff --git a/include/linux/nospec.h b/include/linux/nospec.h
> new file mode 100644
> index 000000000000..cf7be4bbcf17
> --- /dev/null
> +++ b/include/linux/nospec.h
> @@ -0,0 +1,72 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright(c) 2018 Linus Torvalds. All rights reserved.
> +// Copyright(c) 2018 Alexei Starovoitov. All rights reserved.
> +// Copyright(c) 2018 Intel Corporation. All rights reserved.
> +
> +#ifndef _LINUX_NOSPEC_H
> +#define _LINUX_NOSPEC_H


Hmmm, shouldn't we include asm/barrier.h here? Otherwise users might or might not
use the optimized variant depending on which headers are included by the users
of array_index_nospec.


> +
> +/**
> + * array_index_mask_nospec() - generate a ~0 mask when index < size, 0 otherwise
> + * @index: array element index
> + * @size: number of elements in array
> + *
> + * When @index is out of bounds (@index >= @size), the sign bit will be
> + * set.  Extend the sign bit to all bits and invert, giving a result of
> + * zero for an out of bounds index, or ~0 if within bounds [0, @size).
> + */
> +#ifndef array_index_mask_nospec
> +static inline unsigned long array_index_mask_nospec(unsigned long index,
> +		unsigned long size)
> +{
> +	/*
> +	 * Warn developers about inappropriate array_index_nospec() usage.
> +	 *
> +	 * Even if the CPU speculates past the WARN_ONCE branch, the
> +	 * sign bit of @index is taken into account when generating the
> +	 * mask.
> +	 *
> +	 * This warning is compiled out when the compiler can infer that
> +	 * @index and @size are less than LONG_MAX.
> +	 */
> +	if (WARN_ONCE(index > LONG_MAX || size > LONG_MAX,
> +			"array_index_nospec() limited to range of [0, LONG_MAX]\n"))
> +		return 0;
> +
> +	/*
> +	 * Always calculate and emit the mask even if the compiler
> +	 * thinks the mask is not needed. The compiler does not take
> +	 * into account the value of @index under speculation.
> +	 */
> +	OPTIMIZER_HIDE_VAR(index);
> +	return ~(long)(index | (size - 1UL - index)) >> (BITS_PER_LONG - 1);
> +}
> +#endif
> +
> +/*
> + * array_index_nospec - sanitize an array index after a bounds check
> + *
> + * For a code sequence like:
> + *
> + *     if (index < size) {
> + *         index = array_index_nospec(index, size);
> + *         val = array[index];
> + *     }
> + *
> + * ...if the CPU speculates past the bounds check then
> + * array_index_nospec() will clamp the index within the range of [0,
> + * size).
> + */
> +#define array_index_nospec(index, size)					\
> +({									\
> +	typeof(index) _i = (index);					\
> +	typeof(size) _s = (size);					\
> +	unsigned long _mask = array_index_mask_nospec(_i, _s);		\
> +									\
> +	BUILD_BUG_ON(sizeof(_i) > sizeof(long));			\
> +	BUILD_BUG_ON(sizeof(_s) > sizeof(long));			\
> +									\
> +	_i &= _mask;							\
> +	_i;								\
> +})
> +#endif /* _LINUX_NOSPEC_H */
> 
