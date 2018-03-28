Return-Path: <mhocko@kernel.org>
X-Google-Smtp-Source: AIpwx4/QEqBFYuHDaMl3cTcjXCtr3d/tQVQlpFSJAfA+an3Ugi0oxRBxASvtl5d+TMDzXOkEpUud
ARC-Seal: i=1; a=rsa-sha256; t=1522243309; cv=none;
        d=google.com; s=arc-20160816;
        b=Iy5Q8rI7ZE1j2CkXctSMis/vQYlGWPhaunAAby5DxoUVa6JH39Pp4mQRmJkjN7IP7w
         BB54hANywvFRIGH30fLEDJm+JSrorDv08iNZ5ziNGvVe2jTd507QMc7HOUBHHzNZNYZM
         bLZZak524S7a09igUi/tCj4zQKTS5pWfrsPX4fJKCZ29+Gts488nhFlcxw0TaX3WVu3o
         gPnB46yfIGRfzBqxKbAaGjlFJrI4EF3m06qSeq7kC01eTlk4l9ERkLPGW/0YKYik6qXv
         oroFdLf9LoHPTadIPmbwNMDrK5031wuOVnlTStSrteqqzURQuWDalr0MyCTUBv/kFAYF
         zE1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=ybONtbcVMB9HMO+rK6qM3iYAVcNnA01ILaF5Dr6ymFI=;
        b=j71WZfrb0KxmYtAyQ8RulehkZOtQgxpIOuS+Ou0dVbNLbmsWcnagB5lhHHPYNCzXY4
         J/AOGelJh1uyS5dUTw6tWuAT/wmFO1lTDd7wAIjjQEbPvl7kXvOJuXPMSwu8g/e25bSK
         qsHkYJEs3CMP+vr8Yhh5X5OnpYlJTGxXyZ6bCzFWZj2FlqUwsr8weHEpwfVLnyz+ZrIK
         rVzGAKc1TYJdvpekEcB7+z67nL2RThuK2a/tR6LYIzoH3pQAaukvZYaoIVIx+vpZAS8s
         QAHYaEwGGgRNurkInYAd2RzV50ZEwVBWWsl7yStWVirYNc9BV1YlZa5aqKFPe3WD6NPi
         9eEg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of mhocko@kernel.org) smtp.mailfrom=mhocko@kernel.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of mhocko@kernel.org) smtp.mailfrom=mhocko@kernel.org
Date: Wed, 28 Mar 2018 15:21:48 +0200
From: Michal Hocko <mhocko@kernel.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Sasha Levin <levinsasha928@gmail.com>,
	Dave Chinner <david@fromorbit.com>,
	"Darrick J. Wong" <darrick.wong@oracle.com>,
	Christoph Hellwig <hch@lst.de>, xfs <linux-xfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
	Sasha Levin <alexander.levin@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Julia Lawall <julia.lawall@lip6.fr>,
	Josh Triplett <josh@joshtriplett.org>, Takashi Iwai <tiwai@suse.de>,
	Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] xfs: always free inline data before resetting inode fork
 during ifree
Message-ID: <20180328132148.GN9275@dhcp22.suse.cz>
References: <20171123060137.GL2135@magnolia>
 <20180323013037.GA9190@wotan.suse.de>
 <20180323034145.GH4818@magnolia>
 <20180323170813.GD30543@wotan.suse.de>
 <20180323172620.GK4818@magnolia>
 <20180323182302.GB9190@wotan.suse.de>
 <20180325223357.GJ18129@dastard>
 <CA+1xoqdWBumgCn9iw7FH_6VtDnEmd5_Hyw=cY4b9zB=Avhx-4g@mail.gmail.com>
 <20180327070637.GX5652@dhcp22.suse.cz>
 <20180327195435.GE9190@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180327195435.GE9190@wotan.suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1595753768288631831?=
X-GMAIL-MSGID: =?utf-8?q?1596187800139537151?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue 27-03-18 19:54:35, Luis R. Rodriguez wrote:
> On Tue, Mar 27, 2018 at 09:06:37AM +0200, Michal Hocko wrote:
> > So by no means the MM backports were reviewed by me. And considering how hard
> > it is to get any review for MM patches in general I strongly suspect that
> > others didn't review either.
> > 
> > In general I am quite skeptical about the automagic backports
> > selections, to be honest. MM patches should be reasonably good at
> > selecting stable backports and adding more patches on top just risks
> > regressions. 
> 
> BTW other than suggesting we needing *actual review* of the MM patches, are
> there known unit tests which could be run as well? Thinking long term.

There are some in selftests but most fixes are quite hard to get a
specialized testcase for. Rememeber the MM is a pile of heuristics to
handle large scale of workloads.

-- 
Michal Hocko
SUSE Labs
