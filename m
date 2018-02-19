Return-Path: <robert.m.harris@oracle.com>
X-Google-Smtp-Source: AH8x224QjA/zsYaPGF7CqetHraPmNqmu1eQLZI9Qo31orOblla/uTwquoUZHX2cxu3RvPKnfBpbn
ARC-Seal: i=1; a=rsa-sha256; t=1519051488; cv=none;
        d=google.com; s=arc-20160816;
        b=iO65iqyezMU/ImwWGTEeFYxq8iILKeLKW6nMgqcN+qtjvL5p5spKQSxtC9SNUqhqf2
         lDBpNd2xcrIsUbl79lwRU1o9c+hiY0tPkuzJW5rtanKQH6+6F9enj7C71Pku3mPg8BVd
         F198qBx6rAiL6PO6J8ssadxUwgveLjNDFFIu39n/K22qhJe/qMBiPSgV11S4a874k+IU
         3f5b11IsppeuUzb9/JOIIXZmnj3axYP9eaL0gE0x2m8OFkeHF3jez+MM/vHwDRNiKW4/
         Ev1ByYMuVbZ2dP2cxvdCdVwyUEUr16SfA1Rk9ocD7g63p119rb97ILfHEevi1T7kyMpq
         duBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:dkim-signature
         :arc-authentication-results;
        bh=XxsaNdtDYrb8e13yDVcMk47yqSvwvx7kjVYBTIeRDjs=;
        b=w8SB7M9XYyuAwYxboFh1TCr5WQzVKct8R+/5p6K/EIf0rK7a0a/O+I8urklbzM0M6W
         6stWLNYu/MTxio98hm+RLAxgElKIN5q8b3Q9WuORsEBeEHesPBqhwsunOUncr9rOBMTE
         39L2u5rDXgmwjL5rbccSLdqDSRFeej4bjCGHdS9H+Cg7pBQBmbZMSQvOFCOlQkDpLQHL
         pdFYQ3HhZ6jbAXzlgV7/yCv1ffnYCx83yzvgrbn9R6ISUTWa2iv2eDuDuQ5UsK+zwtvF
         Ru6H0QnflCWLvxZCrfaYECIk5GM2fkH/BpHuZ79U8VH9Lzi1nOcpLclCERe3hdv3iHH/
         uA2A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=WC/dI8rm;
       spf=pass (google.com: domain of robert.m.harris@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=robert.m.harris@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=WC/dI8rm;
       spf=pass (google.com: domain of robert.m.harris@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=robert.m.harris@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH 1/1] mm, compaction: correct the bounds of
 __fragmentation_index()
From: Robert Harris <robert.m.harris@oracle.com>
In-Reply-To: <20180219131024.oqonm6ba3pl2l4qa@suse.de>
Date: Mon, 19 Feb 2018 14:37:02 +0000
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
Content-Transfer-Encoding: quoted-printable
Message-Id: <EBC66026-6A17-4F90-920D-859921C7D9B9@oracle.com>
References: <1518972475-11340-1-git-send-email-robert.m.harris@oracle.com>
 <1518972475-11340-2-git-send-email-robert.m.harris@oracle.com>
 <20180219094735.g4sm4kxawjnojgyd@suse.de>
 <CB73A16F-5B32-4681-86E3-00786C67ADEF@oracle.com>
 <20180219131024.oqonm6ba3pl2l4qa@suse.de>
To: Mel Gorman <mgorman@suse.de>
X-Mailer: Apple Mail (2.3445.5.20)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8808 signatures=668674
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=948
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802190183
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592757962533260207?=
X-GMAIL-MSGID: =?utf-8?q?1592840933386406615?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



> On 19 Feb 2018, at 13:10, Mel Gorman <mgorman@suse.de> wrote:
>=20
> On Mon, Feb 19, 2018 at 12:26:39PM +0000, Robert Harris wrote:
>>=20
>>=20
>>> On 19 Feb 2018, at 09:47, Mel Gorman <mgorman@suse.de> wrote:
>>>=20
>>> On Sun, Feb 18, 2018 at 04:47:55PM +0000, robert.m.harris@oracle.com =
wrote:
>>>> From: "Robert M. Harris" <robert.m.harris@oracle.com>
>>>>=20
>>>> __fragmentation_index() calculates a value used to determine =
whether
>>>> compaction should be favoured over page reclaim in the event of =
allocation
>>>> failure.  The calculation itself is opaque and, on inspection, does =
not
>>>> match its existing description.  The function purports to return a =
value
>>>> between 0 and 1000, representing units of 1/1000.  Barring the case =
of a
>>>> pathological shortfall of memory, the lower bound is instead 500.  =
This is
>>>> significant because it is the default value of =
sysctl_extfrag_threshold,
>>>> i.e. the value below which compaction should be avoided in favour =
of page
>>>> reclaim for costly pages.
>>>>=20
>>>> This patch implements and documents a modified version of the =
original
>>>> expression that returns a value in the range 0 <=3D index < 1000.  =
It amends
>>>> the default value of sysctl_extfrag_threshold to preserve the =
existing
>>>> behaviour.
>>>>=20
>>>> Signed-off-by: Robert M. Harris <robert.m.harris@oracle.com>
>>>=20
>>> You have to update sysctl_extfrag_threshold as well for the new =
bounds.
>>=20
>> This patch makes its default value zero.
>>=20
>=20
> Sorry, I'm clearly blind.
>=20
>>> It effectively makes it a no-op but it was a no-op already and =
adjusting
>>> that default should be supported by data indicating it's safe.
>>=20
>> Would it be acceptable to demonstrate using tracing that in both the
>> pre- and post-patch cases
>>=20
>>  1. compaction is attempted regardless of fragmentation index,
>>     excepting that
>>=20
>>  2. reclaim is preferred even for non-zero fragmentation during
>>     an extreme shortage of memory
>>=20
>=20
> If you can demonstrate that for both reclaim-intensive and
> compaction-intensive workloads then yes. Also include the reclaim and
> compaction stats from /proc/vmstat and not just tracepoints to =
demonstrate
> that reclaim doesn't get out of control and reclaim the world in
> response to failed high-order allocations such as THP.

Understood.  Thanks.

Robert Harris=
