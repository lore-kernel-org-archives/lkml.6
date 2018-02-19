Return-Path: <robert.m.harris@oracle.com>
X-Google-Smtp-Source: AH8x226u3kK8TP8NlJMMDTboRDANBRIBsalMBdOJRgS1BHns78JFmmiycCDNGbvNdQIK/TWP1D7+
ARC-Seal: i=1; a=rsa-sha256; t=1519043233; cv=none;
        d=google.com; s=arc-20160816;
        b=w88fOzKpTguMKqDUHa9jt1xlnVxsegilZ+xJA8+uCGVbLkAr1BAGtbSoJGWyi1CIhe
         JCANQRfW+z9z96OuLT9vYFkpshoYWuTIdyaWEvMD8K1XQmcEAxFgl1sj2YczEbMxEEm0
         KnDGkoVYbJAvFH1dcuXlV0r12CzxSeeE71cPDvOSMhrib8osgxBieJEXsbKN6DMSzkoR
         E7pN1W6R+PZev9gaCFSaUA4CqKOx9U3L4YcTSJ1iiKJ1nXpGQnAn9KGIqSRMPfBSaRm/
         0DF2gQQG02i4DvDlz/luR+jdVqm9F3NudJnbS0Ny4/xQX14bUshvzfgUUsjsVgb1dZUX
         5VYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:dkim-signature
         :arc-authentication-results;
        bh=mrIPkCUXrQhHahUyNkveafHDa+bsFOSUyD1M/UE9q3E=;
        b=N9/TyeEqHeHtWTwyDJX/V+fxGxxdDecoPGOovu2pyS7YVWHnX9T5K/xM+u68EuP2hP
         3v+h18JL11hOq+CbiaJ/RPgmnQP8GVxvtyHrRuGQAxcR1C/pgPG94mAD81gQgJlQoBK5
         CWsW+nKhOFfE9AlRc0ljCNmV6VcYRuB0gfI9szYORSlZTooYgHCW0KP+V3Bu63YNVa6Y
         5u5J+NTyyS0YgyKMQm6ZxP0lEeqfct//9qCfivk0U0M2PPI9CDhoJ0/0mvCoPL2b9wZ4
         PeqOUVrsu5ipT3xpWyHCRELDiYesXkjS32zYaJYbK97q/rQBsdh41UJzGlfcyrQ9nA7X
         t95w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=RK/nEs7L;
       spf=pass (google.com: domain of robert.m.harris@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=robert.m.harris@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=RK/nEs7L;
       spf=pass (google.com: domain of robert.m.harris@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=robert.m.harris@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH 1/1] mm, compaction: correct the bounds of
 __fragmentation_index()
From: Robert Harris <robert.m.harris@oracle.com>
In-Reply-To: <20180219094735.g4sm4kxawjnojgyd@suse.de>
Date: Mon, 19 Feb 2018 12:26:39 +0000
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Kemi Wang <kemi.wang@intel.com>,
        David Rientjes <rientjes@google.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Kangmin Park <l4stpr0gr4m@gmail.com>,
        Yisheng Xie <xieyisheng1@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Vinayak Menon <vinmenon@codeaurora.org>
Content-Transfer-Encoding: 7bit
Message-Id: <CB73A16F-5B32-4681-86E3-00786C67ADEF@oracle.com>
References: <1518972475-11340-1-git-send-email-robert.m.harris@oracle.com>
 <1518972475-11340-2-git-send-email-robert.m.harris@oracle.com>
 <20180219094735.g4sm4kxawjnojgyd@suse.de>
To: Mel Gorman <mgorman@suse.de>
X-Mailer: Apple Mail (2.3445.5.20)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8808 signatures=668674
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802190153
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592757962533260207?=
X-GMAIL-MSGID: =?utf-8?q?1592832276984533394?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



> On 19 Feb 2018, at 09:47, Mel Gorman <mgorman@suse.de> wrote:
> 
> On Sun, Feb 18, 2018 at 04:47:55PM +0000, robert.m.harris@oracle.com wrote:
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
>> 
>> Signed-off-by: Robert M. Harris <robert.m.harris@oracle.com>
> 
> You have to update sysctl_extfrag_threshold as well for the new bounds.

This patch makes its default value zero.

> It effectively makes it a no-op but it was a no-op already and adjusting
> that default should be supported by data indicating it's safe.

Would it be acceptable to demonstrate using tracing that in both the
pre- and post-patch cases

  1. compaction is attempted regardless of fragmentation index,
     excepting that

  2. reclaim is preferred even for non-zero fragmentation during
     an extreme shortage of memory

?

Robert Harris
