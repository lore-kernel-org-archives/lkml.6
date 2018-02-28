Return-Path: <konrad.wilk@oracle.com>
X-Google-Smtp-Source: AG47ELs2QDqyNQiIu+afjiMs3/+0ziFT8kIE7OWoy1K3qwo+hGcAynp7JGwVL1yPXR8ifUweg5lS
ARC-Seal: i=1; a=rsa-sha256; t=1519852290; cv=none;
        d=google.com; s=arc-20160816;
        b=CYty2Ck1qrctQDoCIyGSpxFJyJzbq6hwFzpRKFA5gFgJEpxKnHeQXmqnO/9zpYbinh
         MBaYBms+NB7ZRxph9DUD7niSTXk3Fuvabs/bgpM2TrABl20x/tTNM3OlyX7Enw5L5aXy
         Io74SC6Pb//rWEod7FUXTxigP6GcB5o7h/G6KV9NFcf6RQeeFMkxjeRrx9E0z8M8vdkD
         2S4NENTD5UYw1AxMTs50GX8j86jrDat/I1Bo2F/ajle9ClV7nXdIKbrLSr1rCkcIaheI
         JcnyWUqbVf6b3isuPO9ak/EN5AZgnoaTu9cYIxcDxzJF6xJrM2guLzsVNX+zGqdiPlQ7
         lTBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=OmQ87XdqNlJ2hTuj1MXw0jqDbJggj34qnBgPKGJNeGM=;
        b=QF9CkxRMZzR2fyeKyZA42F184n/ol4U0Lx+9+l9ta9wl+IUs8Y4Y6y13COT43k4KT2
         13dGEaimcmSWxkFBR4JXNQPlaXr3cOH0OKCkjox3KI76SF/+3DPoBbiPcgAiTaJELaKI
         zr6HQFPLg60vkPq266F90duvwjDhjU1bSqjjM2t1GTq/LDEXrnwTf8CJnK1V/0sziBNF
         WCJgrmXsev1F9XQB2p4cPN0B7Oa+fMKKitLATie27McOWPCuPEqYtDQOxDj+qutUnxVs
         3FQa45T0qa69ogETJ5R8fB/5yjltbPAqsDkzTV+aht3T6mZfELvoJEG6tAhgWNkKzcKl
         IK4A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=rGvaW9g1;
       spf=pass (google.com: domain of konrad.wilk@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=konrad.wilk@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=rGvaW9g1;
       spf=pass (google.com: domain of konrad.wilk@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=konrad.wilk@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Date: Wed, 28 Feb 2018 16:10:53 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Maran Wilson <maran.wilson@oracle.com>
Cc: pbonzini@redhat.com, jgross@suse.com, boris.ostrovsky@oracle.com,
        roger.pau@citrix.com, andrew.cooper3@citrix.com, hch@infradead.org,
        JBeulich@suse.com, x86@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        thomas.lendacky@amd.com, dave.hansen@linux.intel.com,
        rkrcmar@redhat.com, gregkh@linuxfoundation.org, mchehab@kernel.org,
        hpa@zytor.com, linus.walleij@linaro.org, mingo@redhat.com,
        rdunlap@infradead.org, luto@kernel.org, jpoimboe@redhat.com,
        tglx@linutronix.de, bp@suse.de, davem@davemloft.net,
        kirill.shutemov@linux.intel.com
Subject: Re: [Xen-devel] [RFC PATCH v4 4/7] xen/pvh: Move Xen specific PVH VM
 initialization out of common code
Message-ID: <20180228211053.GM11576@char.us.oracle.com>
References: <1519842483-8887-1-git-send-email-maran.wilson@oracle.com>
 <1519842483-8887-5-git-send-email-maran.wilson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519842483-8887-5-git-send-email-maran.wilson@oracle.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8818 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802280256
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593670492940069413?=
X-GMAIL-MSGID: =?utf-8?q?1593680635841619247?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 28, 2018 at 10:28:00AM -0800, Maran Wilson wrote:
> We need to refactor PVH entry code so that support for other hypervisors
> like Qemu/KVM can be added more easily.
> 
> This patch moves the small block of code used for initializing Xen PVH
> virtual machines into the Xen specific file. This initialization is not
> going to be needed for Qemu/KVM guests. Moving it out of the common file
> is going to allow us to compile kernels in the future without CONFIG_XEN
> that are still capable of being booted as a Qemu/KVM guest via the PVH
> entry point.
> 
> Signed-off-by: Maran Wilson <maran.wilson@oracle.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Thank you!
