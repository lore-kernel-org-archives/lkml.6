Return-Path: <juri.lelli@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521643836; cv=none;
        d=google.com; s=arc-20160816;
        b=0MolREv/MSYXOzvsiXO0Ee0ECQRIrYj2/goDidyykGsRC6cD9gbVNYG4YWRXuPGsp0
         uLQ1XPH7+9P5iowh65xpUlp6M0vQ1GWq71i01MwzddS999qRk9POVR8jpPTBt8m5b8/h
         3KoMdHNen8rRc1g3YGqhSADrtIOXQlR4AXI1wROnchQ3407Z+5c58PY0VXG6SOCQLuXb
         DnrwK4fXem6KXWYDh5D9SqCIOP9QMN02W7eJv7lg4j6yGi+P+qplGggjN+tlVofiasC0
         AA+UgUj1ZL6i/2raXvNTCUa9pSwkq5aKWfhZtFRMS7BrtR4zKv53op4EjP9JCKu62Gt6
         aCFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=etje9eadyyy74nXkJrX8TSw7z/q4cgxTbu5bEnXop8E=;
        b=kmqD4TXraoGT5YfZCISB2sIj36STVWmPbKJGuEthm7eDk8GlTiLJL8eIZ61GgpRLiX
         0bScK36AMxY5qjz3QYOCgploJXrNZEHwM4crYHwXTZsGJcomQQQM97UNSQtd3rFzIaw8
         0nIo4N94pCieSzVo2t4X6uPju8P1qErBTribGDXmanCz6r4rIUu9nrjqN4LGJ4cyHoX3
         hR/Xb/Vbk63hBLCriW2ywuokLPNn4whuZAe8Ai7vhrf0use4dYUWo8L973KCT6k4ROcU
         XUBpKr1ABR6ow4880/LIOJEHlCoghivGkFcoOr1s54z/p8BVA1tUYLk2+P46Ra67LiVu
         EBYQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=QK/ZDczI;
       spf=pass (google.com: domain of juri.lelli@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=juri.lelli@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=QK/ZDczI;
       spf=pass (google.com: domain of juri.lelli@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=juri.lelli@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELv3shFfH1NfqevM31Pc0D03GJXsdn7EnB6lLC25vStnVe1i2Xt4vbBBgGt1wREhn5fapztp5w==
Date: Wed, 21 Mar 2018 15:50:32 +0100
From: Juri Lelli <juri.lelli@gmail.com>
To: Quentin Perret <quentin.perret@arm.com>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Thara Gopinath <thara.gopinath@linaro.org>,
	linux-pm@vger.kernel.org,
	Morten Rasmussen <morten.rasmussen@arm.com>,
	Chris Redpath <chris.redpath@arm.com>,
	Valentin Schneider <valentin.schneider@arm.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>
Subject: Re: [RFC PATCH 4/6] sched/fair: Introduce an energy estimation
 helper function
Message-ID: <20180321145032.GD15165@localhost.localdomain>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com>
 <20180320094312.24081-5-dietmar.eggemann@arm.com>
 <20180321123921.GB13951@e110439-lin>
 <20180321142630.GB2168@queper01-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321142630.GB2168@queper01-VirtualBox>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595449339672655930?=
X-GMAIL-MSGID: =?utf-8?q?1595559207813530783?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 21/03/18 14:26, Quentin Perret wrote:
> On Wednesday 21 Mar 2018 at 12:39:21 (+0000), Patrick Bellasi wrote:
> > On 20-Mar 09:43, Dietmar Eggemann wrote:

[...]

> > 
> > If that's the case then, in the previous function, you can certainly
> > avoid the initialization of *cs and maybe also add an explicit:
> > 
> >     BUG_ON(em->nb_cap_states == 0);
> > 
> > which helps even just as "in code documentation".
> > 
> > But, I'm not sure if maintainers like BUG_ON in scheduler code :)
> 
> Yes, I'm not sure about the BUG_ON either :). I agree that it would be
> nice to document somewhere that compute_energy() is unsafe to call
> without sched_energy_present. I can simply add a proper doc comment to
> this function actually. Would that work ?

If it is something that must not happen and it is also non recoverable
at runtime, then...

$ git grep BUG_ON -- kernel/sched/ | wc -l
50

:)
