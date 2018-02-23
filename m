Return-Path: <robert.m.harris@oracle.com>
X-Google-Smtp-Source: AG47ELv9Bhmeq02GcrfAPuua9cu4XAPG0Bjv3iBHzc0H6v+H1tOQWEBSoMvdLto3z4tJBNGOyyuy
ARC-Seal: i=1; a=rsa-sha256; t=1519393238; cv=none;
        d=google.com; s=arc-20160816;
        b=YTvihNAkrZi9ToQQ/8odTbVNstnVB7KVauplEvgbaqgzZhEdtTwPIrc34r8cV6yyiJ
         sexKmiI9s1Y3RC8WBgKTsG5amSKs8NQIpmNGwsunlpTFEaeLxwrBSOhQxFVGph+IEaot
         pXnvFg4egQzsodoRRuApOJruM2l9AAk+1Zw94rcH6EMpn4Yl7TBgrWqM8PuZXXJbIM9/
         M0JlQFMXVHi3P/7VEN0pw7ErJYk9dUrHUd7swCyiYQhjEPCbT2nsH++Fk8qBslOD4nDR
         WWm0t9MOUtN+Pc/GlLGcyXgVfQEqNXQDSjUUIycMbK53zdeXATHAbZG76oMraTIuZMms
         Hfcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:dkim-signature
         :arc-authentication-results;
        bh=Y6EpJYxvh8a7o7j6d0TNZXRnPP0CuMo598sEyUnAO3I=;
        b=kepfLqQ99c7TZjw07idBHAQS7xy+PRSIsxnQrkK9xVP5cUG8pC6xgGvHZBpPIxoiNQ
         GL6E0anmQSOc/eVf224yN36JX/U2oUSQ7y7d/eC71rw22bJOXY7MtYmKqqIQE5Q27WLA
         XiD5Xc92dJeUzd4KVDhkZnFQspicp6F/K2FuXOi18kvJzUsDqElb/bP7+VLjQRCKirPr
         XEJ3/GJlyZbw/6Zl8hbdog4ir5Kl1GAtL54vrg1QF3qO/CySwUQZL4zE3c8hWvWHqWRm
         +GlqNvW6+Knu8gNtgyX8/r1tjadKeXOEGI1vDWDCqdGIFJ/PEi1O8xSYQTNOPdA0ntcn
         InYg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=lNZuPT2c;
       spf=pass (google.com: domain of robert.m.harris@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=robert.m.harris@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=lNZuPT2c;
       spf=pass (google.com: domain of robert.m.harris@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=robert.m.harris@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH 1/1] mm, compaction: correct the bounds of
 __fragmentation_index()
From: Robert Harris <robert.m.harris@oracle.com>
In-Reply-To: <20180223091020.GS30681@dhcp22.suse.cz>
Date: Fri, 23 Feb 2018 13:40:09 +0000
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
Content-Transfer-Encoding: quoted-printable
Message-Id: <2958E989-B084-4DA3-8350-CD20AD04392B@oracle.com>
References: <1518972475-11340-1-git-send-email-robert.m.harris@oracle.com>
 <1518972475-11340-2-git-send-email-robert.m.harris@oracle.com>
 <20180219082649.GD21134@dhcp22.suse.cz>
 <E718672A-91A0-4A5A-91B5-A6CF1E9BD544@oracle.com>
 <20180219123932.GF21134@dhcp22.suse.cz>
 <90E01411-7511-4E6C-BDDF-74E0334E24FC@oracle.com>
 <20180223091020.GS30681@dhcp22.suse.cz>
To: Michal Hocko <mhocko@kernel.org>
X-Mailer: Apple Mail (2.3445.5.20)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8812 signatures=668677
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802230172
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592757962533260207?=
X-GMAIL-MSGID: =?utf-8?q?1593199284329189142?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



> On 23 Feb 2018, at 09:10, Michal Hocko <mhocko@kernel.org> wrote:
>=20
> On Mon 19-02-18 14:30:36, Robert Harris wrote:
>>=20
>>=20
>>> On 19 Feb 2018, at 12:39, Michal Hocko <mhocko@kernel.org> wrote:
>>>=20
>>> On Mon 19-02-18 12:14:26, Robert Harris wrote:
>>>>=20
>>>>=20
>>>>> On 19 Feb 2018, at 08:26, Michal Hocko <mhocko@kernel.org> wrote:
>>>>>=20
>>>>> On Sun 18-02-18 16:47:55, robert.m.harris@oracle.com wrote:
>>>>>> From: "Robert M. Harris" <robert.m.harris@oracle.com>
>>>>>>=20
>>>>>> __fragmentation_index() calculates a value used to determine =
whether
>>>>>> compaction should be favoured over page reclaim in the event of =
allocation
>>>>>> failure.  The calculation itself is opaque and, on inspection, =
does not
>>>>>> match its existing description.  The function purports to return =
a value
>>>>>> between 0 and 1000, representing units of 1/1000.  Barring the =
case of a
>>>>>> pathological shortfall of memory, the lower bound is instead 500. =
 This is
>>>>>> significant because it is the default value of =
sysctl_extfrag_threshold,
>>>>>> i.e. the value below which compaction should be avoided in favour =
of page
>>>>>> reclaim for costly pages.
>>>>>>=20
>>>>>> This patch implements and documents a modified version of the =
original
>>>>>> expression that returns a value in the range 0 <=3D index < 1000. =
 It amends
>>>>>> the default value of sysctl_extfrag_threshold to preserve the =
existing
>>>>>> behaviour.
>>>>>=20
>>>>> It is not really clear to me what is the actual problem you are =
trying
>>>>> to solve by this patch. Is there any bug or are you just trying to
>>>>> improve the current implementation to be more effective?
>>>>=20
>>>> There is not a significant bug.
>>>>=20
>>>> The first problem is that the mathematical expression in
>>>> __fragmentation_index() is opaque, particularly given the lack of
>>>> description in the comments or the original commit message.  This =
patch
>>>> provides such a description.
>>>>=20
>>>> Simply annotating the expression did not make sense since the =
formula
>>>> doesn't work as advertised.  The fragmentation index is described =
as
>>>> being in the range 0 to 1000 but the bounds of the formula are =
instead
>>>> 500 to 1000.  This patch changes the formula so that its lower =
bound is
>>>> 0.
>>>=20
>>> But why do we want to fix that in the first place? Why don't we =
simply
>>> deprecate the tunable and remove it altogether? Who is relying on =
tuning
>>> this option. Considering how it doesn't work as advertised and =
nobody
>>> complaining I have that feeling that it is not really used in =
wild=E2=80=A6
>>=20
>> I think it's a useful feature.  Ignoring any contrived test case, =
there
>> will always be a lower limit on the degree of fragmentation that can =
be
>> achieved by compaction.  If someone takes the trouble to measure this
>> then it is entirely reasonable that he or she should be able to =
inhibit
>> compaction for cases when fragmentation falls below some =
correspondingly
>> sized threshold.
>=20
> Do you have any practical examples?

Are you looking for proof that the existing feature is useful?

It is possible today to induce compaction, observe a fragmentation index
and then use the same index as a starting point for setting the
tuneable.  The fact that the actual range of reported indices is
500--1000 rather than the documented 0--1000 would have no practical
effect on this approach.  Therefore that fact that the feature doesn't
work precisely as advertised does not mean that it is not useful.

If you are asking me to prove whether modifying the tuneable in the
manner above, thereby preferring compaction for more fragmented systems,
is successful then I can't answer now.  I assume that the onus would
have been on Mel to show this at the time of the original commit.
However, I interpret his last comment on this patch as a request to
verify that changing the preference yields sane results.

Robert Harris
