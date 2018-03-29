Return-Path: <mhocko@kernel.org>
X-Google-Smtp-Source: AIpwx4/pnBDavUbxaH12gG6aOSubvG5FBYFRDS9VBCuTRQidgtrYyUhF9T5TAKvKerakWOobeU6q
ARC-Seal: i=1; a=rsa-sha256; t=1522306914; cv=none;
        d=google.com; s=arc-20160816;
        b=T2X5eZwdU2rJ1X9nyg9f+B3mFfvCfhU7fk86BIOeyxf63orl0Ggmo9XFQzQ4gEFEkZ
         t/N3dUEkCCu9FmDAuuyAItaXWgzWwKb1oU4kAHiNn8duqAT/Lwan8wUOlXScJNA+i3tb
         XhwUtvPSwA0xlUpf/390hD4OQPcAXVngnsv83lx4Nf4oEy5n9y2alTgPcjtvL6UTKrql
         zzxXAVUUHDeHgIqb5T/KksOocqJx+WkRfNpdLTZ8xpTnY+q8lauK/rwxkAfEduTKGlmk
         F3A1gNuDHEC/KGLbpAPe8XatjUanp9a7Lh3usqjTfl+wbat9uQNUBXqOyEXHOvkYJsWE
         h22Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=4gXKBU927zb/DSiW02UUFPNzh0UG6rdf1yLoFTuM2rM=;
        b=wS/jBNOv1EHGeBrnMXgnRpTkqdDo6BsRq3oroqcDHqepxLXa9f+FFGoO7H77kLCZQ/
         fPsaqZD9nT2DdPiPZCbnoZEZlaRJ3PAPjSQvGB6k+f1sAadPbF7dkv91ramv9C4/6CQT
         vIClsCFSbD9mee5MY+aJvPU1tgwqVse1rNrnt1swbD6pqWF4KZdRNb0/LnsUoUtC0z8C
         VbxddBDf3Szt3Av3H3C6mCXTf+nYm/oPjSiKpXUmgAqCcBlXCgVcAwruoZ2NihjwVH6+
         /1h25q6+KBiIjMfEOsbuR8U1SOYeCcW95rp1y2thHb0INApVdX+Bug77YE5f0DlkSvem
         bQjg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of mhocko@kernel.org) smtp.mailfrom=mhocko@kernel.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of mhocko@kernel.org) smtp.mailfrom=mhocko@kernel.org
Date: Thu, 29 Mar 2018 09:01:53 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
	Sasha Levin <levinsasha928@gmail.com>,
	Dave Chinner <david@fromorbit.com>,
	"Darrick J. Wong" <darrick.wong@oracle.com>,
	Christoph Hellwig <hch@lst.de>, xfs <linux-xfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Julia Lawall <julia.lawall@lip6.fr>,
	Josh Triplett <josh@joshtriplett.org>, Takashi Iwai <tiwai@suse.de>,
	Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] xfs: always free inline data before resetting inode fork
 during ifree
Message-ID: <20180329070153.GC31039@dhcp22.suse.cz>
References: <20180323034145.GH4818@magnolia>
 <20180323170813.GD30543@wotan.suse.de>
 <20180323172620.GK4818@magnolia>
 <20180323182302.GB9190@wotan.suse.de>
 <20180325223357.GJ18129@dastard>
 <CA+1xoqdWBumgCn9iw7FH_6VtDnEmd5_Hyw=cY4b9zB=Avhx-4g@mail.gmail.com>
 <20180327070637.GX5652@dhcp22.suse.cz>
 <20180327195435.GE9190@wotan.suse.de>
 <20180328132148.GN9275@dhcp22.suse.cz>
 <20180328193304.GC7561@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328193304.GC7561@sasha-vm>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1595753768288631831?=
X-GMAIL-MSGID: =?utf-8?q?1596254495240692313?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed 28-03-18 19:33:06, Sasha Levin wrote:
> On Wed, Mar 28, 2018 at 03:21:48PM +0200, Michal Hocko wrote:
> >On Tue 27-03-18 19:54:35, Luis R. Rodriguez wrote:
> >> On Tue, Mar 27, 2018 at 09:06:37AM +0200, Michal Hocko wrote:
> >> > So by no means the MM backports were reviewed by me. And considering how hard
> >> > it is to get any review for MM patches in general I strongly suspect that
> >> > others didn't review either.
> >> >
> >> > In general I am quite skeptical about the automagic backports
> >> > selections, to be honest. MM patches should be reasonably good at
> >> > selecting stable backports and adding more patches on top just risks
> >> > regressions.
> >>
> >> BTW other than suggesting we needing *actual review* of the MM patches, are
> >> there known unit tests which could be run as well? Thinking long term.
> >
> >There are some in selftests but most fixes are quite hard to get a
> >specialized testcase for. Rememeber the MM is a pile of heuristics to
> >handle large scale of workloads.
> 
> Would running mmtests for each patch help here at all?

mmtests are more for performance than regression/correctness testing
AFAIR.

-- 
Michal Hocko
SUSE Labs
