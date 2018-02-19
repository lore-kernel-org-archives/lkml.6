Return-Path: <robert.m.harris@oracle.com>
X-Google-Smtp-Source: AH8x227DQ6jel9f2NdkngSBYlXCSw+/zc+RW5HA2v5zAz79Xwn25AR5zyyVOHtEv764tSwseDES+
ARC-Seal: i=1; a=rsa-sha256; t=1519042500; cv=none;
        d=google.com; s=arc-20160816;
        b=oDe+xDfSh9M2mh8rA6KxuHnssPznVnH3SgN43P/QcYeFpKAUHbF3f9LZXSUN7QxXIO
         3nFPrjgMTkmzBPBg09LMgAGfCYcxvIQnG1mjSZAFRrxw5WmYEnAgHbWAOs59UY9LD/xc
         /wAGTYxlXnkflhDlY02w83WxUJAS71AQkOenY2z+BUDUe40rEc7L+QwMFGZAp5JzXX6J
         QVN6z+mXF0va8emVNyt9mgzfwhBnF0O0TmSd92HUnhAcSBKh/teD2KInmnwqsNhjq4Oy
         0aNHPEeEeGmoCrYzJxj5trc0HpExmuGYBGGO/YUhqFVuBx1VbCSj7YDEWdJiunvty8pN
         KFOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:dkim-signature
         :arc-authentication-results;
        bh=SDEfTK3CPl6MnnL0TtTwtkYCJt7oJC2skVFVQ+S+Qrs=;
        b=ij545Ujl5vzCq/jkvtFUtQ1ZUKN+/sdQbpbt2iDnSXxwDpwUtfCBqVaYlNDy+QPHA/
         HLDrHv8XkNhTFCyevcgRA8aIbh8pW5tSuIltqme8xZGtDHRZ9lL2MeCZR1M9KzaacswH
         2v9tBeZQ5RZWFxiSGDGkfp1Dw0PHrvFWDnhUKIH/QYOUoU9Fry98sYQdfZAI/rz6HAxZ
         1N+beiX3a8/ZKO2wyMockBkUidG63JKXSHvKdgSdbuAzBJ4CFzVF/vT/aotaF1duW+N5
         Z6zzG7BFdnkPRJ+NTaSW3ef1CsMfFlS5DC0Z09aVmfW7CfpyHNkXTZz3ygoeRBhfs2jh
         Dmlg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=rx8Uzc6K;
       spf=pass (google.com: domain of robert.m.harris@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=robert.m.harris@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=rx8Uzc6K;
       spf=pass (google.com: domain of robert.m.harris@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=robert.m.harris@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH 1/1] mm, compaction: correct the bounds of
 __fragmentation_index()
From: Robert Harris <robert.m.harris@oracle.com>
In-Reply-To: <20180219082649.GD21134@dhcp22.suse.cz>
Date: Mon, 19 Feb 2018 12:14:26 +0000
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Kemi Wang <kemi.wang@intel.com>,
        David Rientjes <rientjes@google.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Kangmin Park <l4stpr0gr4m@gmail.com>, Mel Gorman <mgorman@suse.de>,
        Yisheng Xie <xieyisheng1@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Vinayak Menon <vinmenon@codeaurora.org>
Content-Transfer-Encoding: 7bit
Message-Id: <E718672A-91A0-4A5A-91B5-A6CF1E9BD544@oracle.com>
References: <1518972475-11340-1-git-send-email-robert.m.harris@oracle.com>
 <1518972475-11340-2-git-send-email-robert.m.harris@oracle.com>
 <20180219082649.GD21134@dhcp22.suse.cz>
To: Michal Hocko <mhocko@kernel.org>
X-Mailer: Apple Mail (2.3445.5.20)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8808 signatures=668674
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802190151
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592757962533260207?=
X-GMAIL-MSGID: =?utf-8?q?1592831509075014492?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



> On 19 Feb 2018, at 08:26, Michal Hocko <mhocko@kernel.org> wrote:
> 
> On Sun 18-02-18 16:47:55, robert.m.harris@oracle.com wrote:
>> From: "Robert M. Harris" <robert.m.harris@oracle.com>
>> 
>> __fragmentation_index() calculates a value used to determine whether
>> compaction should be favoured over page reclaim in the event of allocation
>> failure.  The calculation itself is opaque and, on inspection, does not
>> match its existing description.  The function purports to return a value
>> between 0 and 1000, representing units of 1/1000.  Barring the case of a
>> pathological shortfall of memory, the lower bound is instead 500.  This is
>> significant because it is the default value of sysctl_extfrag_threshold,
>> i.e. the value below which compaction should be avoided in favour of page
>> reclaim for costly pages.
>> 
>> This patch implements and documents a modified version of the original
>> expression that returns a value in the range 0 <= index < 1000.  It amends
>> the default value of sysctl_extfrag_threshold to preserve the existing
>> behaviour.
> 
> It is not really clear to me what is the actual problem you are trying
> to solve by this patch. Is there any bug or are you just trying to
> improve the current implementation to be more effective?

There is not a significant bug.

The first problem is that the mathematical expression in
__fragmentation_index() is opaque, particularly given the lack of
description in the comments or the original commit message.  This patch
provides such a description.

Simply annotating the expression did not make sense since the formula
doesn't work as advertised.  The fragmentation index is described as
being in the range 0 to 1000 but the bounds of the formula are instead
500 to 1000.  This patch changes the formula so that its lower bound is
0.

The fragmentation index is compared to the tuneable
sysctl_extfrag_threshold, which defaults to 500.  If the index is above
this value then compaction is preferred over page reclaim in the event
of allocation failure.  Given the issue above, the index will almost
always exceed the default threshold and compaction will occur even if
there is low fragmentation.  This patch changes the default value of the
tuneable to 0, meaning that the existing behaviour will be unchanged.
Changing sysctl_extfrag_threshold back to something non-zero in a future
patch would effect the behaviour intended by the original code but would
require more comprehensive testing since it would modify the kernel's
performance under memory pressure.

Robert Harris
