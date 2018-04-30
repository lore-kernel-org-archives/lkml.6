Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752407AbeD3HvU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 03:51:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51382 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752134AbeD3HvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 03:51:18 -0400
Date: Mon, 30 Apr 2018 00:51:06 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, shakeelb@google.com,
        stable@kernel.org, tglx@linutronix.de, mpe@ellerman.id.au,
        mingo@kernel.org, akpm@linux-foundation.org, shuah@kernel.org
Subject: Re: [PATCH 4/9] x86, pkeys: override pkey when moving away from
 PROT_EXEC
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <20180326172721.D5B2CBB4@viggo.jf.intel.com>
 <20180326172727.025EBF16@viggo.jf.intel.com>
 <20180407000943.GA15890@ram.oc3035372033.ibm.com>
 <6e3f8e1c-afed-64de-9815-8478e18532aa@intel.com>
 <20180407010919.GB15890@ram.oc3035372033.ibm.com>
 <aedcb0b6-73f5-f72f-742e-b417131895d3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aedcb0b6-73f5-f72f-742e-b417131895d3@intel.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-TM-AS-GCONF: 00
x-cbid: 18043007-0008-0000-0000-000004F15983
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18043007-0009-0000-0000-00001E856F78
Message-Id: <20180430075106.GA5666@ram.oc3035372033.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-30_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804300077
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 10:57:31AM -0700, Dave Hansen wrote:
> On 04/06/2018 06:09 PM, Ram Pai wrote:
> > Well :). my point is add this code and delete the other
> > code that you add later in that function.
> 
> I don't think I'm understanding what your suggestion was.  I looked at
> the code and I honestly do not think I can remove any of it.
> 
> For the plain (non-explicit pkey_mprotect()) case, there are exactly
> four paths through __arch_override_mprotect_pkey(), resulting in three
> different results.
> 
> 1. New prot==PROT_EXEC, no pkey-exec support -> do not override
> 2. New prot!=PROT_EXEC, old VMA not PROT_EXEC-> do not override
> 3. New prot==PROT_EXEC, w/ pkey-exec support -> override to exec pkey
> 4. New prot!=PROT_EXEC, old VMA is PROT_EXEC -> override to default
> 
> I don't see any redundancy there, or any code that we can eliminate or
> simplify.  It was simpler before, but that's what where bug was.

Your code is fine.  But than the following code accomplishes the same
outcome; arguably with a one line change. Its not a big deal. Just
trying to clarify my comment.

int __arch_override_mprotect_pkey(struct vm_area_struct *vma, int prot, int pkey)
{
	/*
	 * Is this an mprotect_pkey() call?  If so, never
	 * override the value that came from the user.
	 */
	if (pkey != -1)
		return pkey;
	/*
	 * Look for a protection-key-drive execute-only mapping
	 * which is now being given permissions that are not
	 * execute-only.  Move it back to the default pkey.
	 */
	if (vma_is_pkey_exec_only(vma) && (prot != PROT_EXEC)) <--------
		return ARCH_DEFAULT_PKEY;

	/*
	 * The mapping is execute-only.  Go try to get the
	 * execute-only protection key.  If we fail to do that,
	 * fall through as if we do not have execute-only
	 * support.
	 */
	if (prot == PROT_EXEC) {
		pkey = execute_only_pkey(vma->vm_mm);
		if (pkey > 0)
			return pkey;
	}
	/*
	 * This is a vanilla, non-pkey mprotect (or we failed to
	 * setup execute-only), inherit the pkey from the VMA we
	 * are working on.
	 */
	return vma_pkey(vma);
}

-- 
Ram Pai
