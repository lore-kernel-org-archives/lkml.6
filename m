Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38BAC5AE59
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 01:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 992B020693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 01:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="WKs+RdBm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 992B020693
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755487AbeFSBgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 21:36:13 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:37850 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755387AbeFSBgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 21:36:11 -0400
Received: by mail-pl0-f67.google.com with SMTP id 31-v6so10018067plc.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 18:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=NG5wlGvnwNC3IqLZX5cTbS8035ctHyfvrCupAGb5uyI=;
        b=WKs+RdBmt8v3N5Nn6VoaUlRB9CZc2oEECUfwmQt5j4GEXnX5XDeCauLsyYYYbtwsrP
         5GjFXenxLZ5Rujp3hVjSbxe9lUhjAJCVazwlqcBHbBs9jxkN55R3zmRWfeWeEh13v9F8
         0TF5Zc/ORkZjx9Ot2RgFfhyC08edorFsDe+QG7bf9RMvJprqbo0SuXZbt2FT35ubAhwE
         q8UY2kaX5fjhGmii+z33QQIvPF6pChyKO/a7bsKGasN+sTpaw7tsWJ6ypQ+VvoZXDjuh
         Ig6I5QKfsJM0EpvR5ydc21xZ8UCrjM0ClTkKf8zcgXZoa6iN1v6x+9HZjHwyiRON0J3f
         lSIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=NG5wlGvnwNC3IqLZX5cTbS8035ctHyfvrCupAGb5uyI=;
        b=o1ikNx9pLguO4m5uJN44NTEbUuc67z6U+6mMuSyfHsGKs+p89Ni/QZomOImjp+U6lA
         eBv0Hb+bkDIO2Cj2jtZt1ubwDrdstrkHCLZdYHYptciXxm7vASkGPCNMQzF9kYH+3R7S
         FRbTLgOR2TMB9Sh0km70aYSJi3NuV2UnhXz0PCkP+OfggfN1bnHtKYeHyFR76XIkVoiD
         17OHEEM3ZaK5wyviqFEdiKP1KN8DsWsiPJ0DnkyKe5HX0oC4lTFqc23MDBixePJyww0c
         w6sBloQ64S0vsvCT9jwEE4qkV7cYasiYD9cbrcKKwxX1b7fMXB7rM+ajQMa2XRRzT5qK
         S71Q==
X-Gm-Message-State: APt69E14UJIG3pIfIKPhdhaZQ51Da0xhKkswcgjDaJ+MrZc8ZLdyQx8F
        FHL/kIrKeImvNZC92Ll5gBSGtDq8v7o=
X-Google-Smtp-Source: ADUXVKI0u+SmxWtpmYHNUOwdL/8LbwLnWHTQEdPdHr9VBePV+I0bpFM6W8LFqgF8S518iqF0yIDNlQ==
X-Received: by 2002:a17:902:7105:: with SMTP id a5-v6mr16399831pll.171.1529372170542;
        Mon, 18 Jun 2018 18:36:10 -0700 (PDT)
Received: from [192.168.0.114] (c-98-210-118-128.hsd1.ca.comcast.net. [98.210.118.128])
        by smtp.gmail.com with ESMTPSA id h84-v6sm25419754pfd.69.2018.06.18.18.36.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 18:36:09 -0700 (PDT)
Date:   Mon, 18 Jun 2018 18:36:06 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20180619010803.GC3593@linux.vnet.ibm.com>
References: <20180610234544.150933-2-joel@joelfernandes.org> <20180613065711.GZ16472@yexl-desktop> <20180613072948.GA142000@joelaf.mtv.corp.google.com> <20180618165646.GA3593@linux.vnet.ibm.com> <20180618222647.GA156172@joelaf.mtv.corp.google.com> <20180619010803.GC3593@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [lkp-robot] [rcutorture]  46e26223e3: WARNING:at_kernel/rcu/rcutorture.c:#rcu_torture_stats_print
To:     paulmck@linux.vnet.ibm.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>
CC:     kernel test robot <xiaolong.ye@intel.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        mingo@redhat.com, Steven Rostedt <rostedt@goodmis.org>,
        tglx@linutronix.de, lkp@01.org
From:   Joel Fernandes <joelaf@google.com>
Message-ID: <2CDE3A5B-1AD3-4185-9E24-24D4075A9EA6@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On June 18, 2018 6:08:03 PM PDT, "Paul E=2E McKenney" <paulmck@linux=2Evne=
t=2Eibm=2Ecom> wrote:
>On Mon, Jun 18, 2018 at 03:26:47PM -0700, Joel Fernandes wrote:
>> On Mon, Jun 18, 2018 at 09:56:46AM -0700, Paul E=2E McKenney wrote:
>> > > The reason for the rcutorture test failure could be that the
>default
>> > > kthread_prio for the system's RCU threads is set to 1 (unless
>overridden by
>> > > rcutree=2Ekthread_prio) which is also equal to the priority of the
>rcutorture's
>> > > boost threads=2E Due to this the rcutorture test could starve the
>RCU threads
>> > > as well and defeat the boosting mechanism=2E I was able to solve a
>similar
>> > > issue by just passing rcutree=2Ekthread_prio of 50 on the kernel
>command line=2E
>> > >=20
>> > > Paul, would it be ok if we changed the default kthread_prio to
>something > 1
>> > > so that rcutorture can test properly without needing to pass any
>extra
>> > > rcutree=2E* parameters?
>> > >=20
>> > > so something like this in kernel/rcu/tree=2Ec ?
>> > >=20
>> > > static int kthread_prio =3D IS_ENABLED(CONFIG_RCU_BOOST) ? 2 : 0;
>> >=20
>> > Would it be possible to also condition this on rcutorture being
>built
>> > in?  Or are they doing modprobes for rcutorture?
>>=20
>> They seem to be doing built-in rcutorture tests=2E But I believe the
>same
>> problem would occur even if you used modules? I believe the fact that
>> rcutorture is a module or built-in wouldn't matter to the underlying
>issue
>> which is the RCU subsystems's threads are at too low of a priority
>> (rcutree=2Ekthread_prio =3D 1)=2E
>
>Understood=2E=2E=2E
>
>> If you agree with changing the default priority, I have included a
>patch
>> below for rcu/dev=2E
>
>The problem is that without rcutorture, rcutree=2Ekthread_prio=3D1 is a
>legitimate choice, and changing the default globally could be breaking
>someone=2E  So it would be far better to up the priority only during
>known
>rcutorture testing=2E

Oh I see what you're saying=2E I'll work on a patch along these lines then=
=2E Thanks!

- Joel




>
>							Thanx, Paul
>
>> thanks,
>>=20
>>  - Joel
>>=20
>> ---8<-----------------------
>>=20
>> >From b0f4111ef1abd1c481c269fadb3535c83ab43c93 Mon Sep 17 00:00:00
>2001
>> From: "Joel Fernandes (Google)" <joel@joelfernandes=2Eorg>
>> Date: Mon, 18 Jun 2018 15:13:10 -0700
>> Subject: [PATCH] rcu: Change default RCU kthread priority to 2
>>=20
>> The current RT priority of 1 for RCU kthreads makes rcutorture's
>boost test
>> fail on systems where rcutree=2Ekthread_prio isn't passed=2E
>>=20
>> The rcutorture boost kthreads have the same priority as well (RT
>priority of
>> 1)=2E Due to this, the rcutorture kthreads starve the RCU subsystem's
>kthreads
>> and causes rcutorture failures=2E This patch changes the priority of
>the RCU
>> subsystem's threads to a default RT priority of 2 so that
>rcutorture's
>> threads get preempted by them=2E Verified that the boost tests will
>pass with
>> this change=2E
>>=20
>> Reported-by: Xiaolong Ye (via lkp-robot) <xiaolong=2Eye@intel=2Ecom>
>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes=2Eorg>
>> ---
>>  kernel/rcu/tree=2Ec | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/kernel/rcu/tree=2Ec b/kernel/rcu/tree=2Ec
>> index deb2508be923=2E=2E920c39e3f871 100644
>> --- a/kernel/rcu/tree=2Ec
>> +++ b/kernel/rcu/tree=2Ec
>> @@ -171,7 +171,7 @@ static void rcu_report_exp_rdp(struct rcu_state
>*rsp,
>>  static void sync_sched_exp_online_cleanup(int cpu);
>>=20
>>  /* rcuc/rcub kthread realtime priority */
>> -static int kthread_prio =3D IS_ENABLED(CONFIG_RCU_BOOST) ? 1 : 0;
>> +static int kthread_prio =3D IS_ENABLED(CONFIG_RCU_BOOST) ? 2 : 0;
>>  module_param(kthread_prio, int, 0644);
>>=20
>>  /* Delay in jiffies for grace-period initialization delays, debug
>only=2E */
>> --=20
>> 2=2E18=2E0=2Erc1=2E244=2Egcf134e6275-goog
>>=20

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
