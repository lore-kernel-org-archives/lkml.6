Return-Path: <darrick.wong@oracle.com>
X-Google-Smtp-Source: AIpwx4/2YB6vAeg0ti9avDhfY3hhyHTbaUVGssr3DjK57wsWavXBePizRafbyXRdsiLyBygWyiv8
ARC-Seal: i=1; a=rsa-sha256; t=1522266059; cv=none;
        d=google.com; s=arc-20160816;
        b=RmcGTOMZb16wDYcHpJzprMiHAZbj6wBBEMYp7ZIyXBgLZOgONYp0h/8MIsXpgPHwdQ
         bOrXLeK+9z5BeEjM3zett3ysi4OB/J2Kkb8W2LMAV6GzujbgghvmCNEtD+fqmGJYGThx
         3BROX+CCKVYn3x9ECMq5FozaJQi06APkHtIzc/zP/sH0p3X9Pt+ARNRH0MCk5Y0Sr2aL
         qHSC+vDwHT9NBTbB1fbESuynbSiN9lBXm1CvDHCMZCV0OTGO/i17Lc3nJFsmpkG3iC3S
         UrndJRDy0xv2hflhz0q5iWR3+ZnB171QTBRjZsXF+6MclqlPoYuG2nyBaewdKv/kvf71
         61BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=nTMeUONdZDE6LdaweM6ThVBaUNihKEaSXiLEigsf+Fo=;
        b=jIsUjsY2tnvfYgF+8wrSG+FSDfa3DXFuykexRLCbJDCgvgdO4V28TKlvONnDfIKBNB
         tXiFTJiuZ42gSyzkx/JtiZdPpFk7MVVb+gA/4Cvbs8CB1/fSHkr5r1az0v1Lhfqccz5p
         Y3BLUKj+q9RzgRLpw8u4oWt+U+7KghxqaXewDoLoiKYh0Chcu9ttD72QT4wLEH0AgP3c
         Iuc3IiVpTnqPf6kVr7mZ2rBPcDq4ez9VWyTtt/LsRww2ZS7x909MlQdbexzSRZQnHXha
         oKl04U0xgNtXwiDtbj5pBPAhyf/lkhBOcIMajbc9NGUro204bfYnkk5NRkOk4BwX4/X1
         4OiQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=sFBzp6di;
       spf=pass (google.com: domain of darrick.wong@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=darrick.wong@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=sFBzp6di;
       spf=pass (google.com: domain of darrick.wong@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=darrick.wong@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Date: Wed, 28 Mar 2018 12:40:17 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: Dave Chinner <david@fromorbit.com>, Sasha Levin <levinsasha928@gmail.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>, xfs <linux-xfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Josh Triplett <josh@joshtriplett.org>, Takashi Iwai <tiwai@suse.de>,
        Michal Hocko <mhocko@kernel.org>, Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] xfs: always free inline data before resetting inode fork
 during ifree
Message-ID: <20180328194017.GM4818@magnolia>
References: <20171123060137.GL2135@magnolia>
 <20180323013037.GA9190@wotan.suse.de>
 <20180323034145.GH4818@magnolia>
 <20180323170813.GD30543@wotan.suse.de>
 <20180323172620.GK4818@magnolia>
 <20180323182302.GB9190@wotan.suse.de>
 <20180325223357.GJ18129@dastard>
 <CA+1xoqdWBumgCn9iw7FH_6VtDnEmd5_Hyw=cY4b9zB=Avhx-4g@mail.gmail.com>
 <20180328033228.GA18129@dastard>
 <20180328193004.GB7561@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328193004.GB7561@sasha-vm>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8846 signatures=668695
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803280196
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1595753768288631831?=
X-GMAIL-MSGID: =?utf-8?q?1596211655889223311?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 07:30:06PM +0000, Sasha Levin wrote:
> On Wed, Mar 28, 2018 at 02:32:28PM +1100, Dave Chinner wrote:
> >How much time are your test rigs going to be able to spend running
> >xfstests? A single pass on a single filesysetm config on spinning
> >disks will take 3-4 hours of run time. And we have at least 4 common
> >configs that need validation (v4, v4 w/ 512b block size, v5
> >(defaults), and v5 w/ reflink+rmap) and so you're looking at a
> >minimum 12-24 hours of machine test time per kernel you'd need to
> >test.
> 
> No reason they can't run in parallel, right?

Correct, parallelizing them turns horrifying long test runs into
manageable quantities.

> >> > From: Sasha Levin <alexander.levin@microsoft.com>
> >> > To: Sasha Levin <alexander.levin@microsoft.com>
> >> > To: linux-xfs@vger.kernel.org, "Darrick J . Wong" <darrick.wong@oracle.com>
> >> > Cc: Brian Foster <bfoster@redhat.com>, linux-kernel@vger.kernel.org
> >> > Subject: Re: [PATCH] xfs: Correctly invert xfs_buftarg LRU isolation logic
> >> > In-Reply-To: <20180306102638.25322-1-vbendel@redhat.com>
> >> > References: <20180306102638.25322-1-vbendel@redhat.com>
> >> >
> >> > Hi Vratislav Bendel,
> >> >
> >> > [This is an automated email]
> >> >
> >> > This commit has been processed by the -stable helper bot and determined
> >> > to be a high probability candidate for -stable trees. (score: 6.4845)
> >> >
> >> > The bot has tested the following trees: v4.15.12, v4.14.29, v4.9.89, v4.4.123, v4.1.50, v3.18.101.
> >> >
> >> > v4.15.12: OK!
> >> > v4.14.29: OK!
> >> > v4.9.89: OK!
> >> > v4.4.123: OK!
> >> > v4.1.50: OK!
> >> > v3.18.101: OK!
> >> >
> >> > Please reply with "ack" to have this patch included in the appropriate stable trees.
> >
> >That might help, but the testing and validation is completely
> >opaque. If I wanted to know what that "OK!" actually meant, where
> >do I go to find that out?
> 
> This is actually something I want maintainers to dictate. What sort of
> testing would make the XFS folks happy here? Right now I'm doing
> "./check 'xfs/*'" with xfstests. Is it sufficient? Anything else you'd like to see?

FWIW /me usually runs ./check '-g auto,quick,clone,dedupe,fsmap,rmap'
with the following four mkfs configs:

MKFS_OPTIONS='-m reflink=1,rmapbt=1, -i sparse=1, -b size=1024,'
MKFS_OPTIONS='-m reflink=1,rmapbt=1, -i sparse=1,'
MKFS_OPTIONS='-m crc=0,reflink=0,rmapbt=0, -i sparse=0,'
MKFS_OPTIONS='-m crc=0,reflink=0,rmapbt=0, -i sparse=0, -b size=512,'

Eventually I'll turn quotas on all the time too, time permitting.

--D

> 
> --
> Thanks,
> Sasha--
> To unsubscribe from this list: send the line "unsubscribe linux-xfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
