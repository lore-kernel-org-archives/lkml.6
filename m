Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D83C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 21:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DFE12082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 21:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="lQqP848S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DFE12082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbeJ3F7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 01:59:03 -0400
Received: from rcdn-iport-8.cisco.com ([173.37.86.79]:34161 "EHLO
        rcdn-iport-8.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbeJ3F7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 01:59:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1386; q=dns/txt; s=iport;
  t=1540847318; x=1542056918;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=P/xNm11nZw5q8XfeLANKDgWh2u4RRx89z45zxgwCwr0=;
  b=lQqP848SjkptHglgLK7E7VummqBioBpI+0zFA3YhTTL/wUHMTgej2ui8
   Dqt5BRGUwoCqvrk3yGQEDQKO7Xvp0BgJ3r5ugXWFyIsQpDCdmWwGIkXYE
   +ZzkbTu98enAxhpXBScQLVOcKid++60YBK/NbSigHAEi7+gMxxfZTKYBp
   A=;
X-IronPort-AV: E=Sophos;i="5.54,441,1534809600"; 
   d="scan'208";a="471041775"
Received: from rcdn-core-11.cisco.com ([173.37.93.147])
  by rcdn-iport-8.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2018 21:08:37 +0000
Received: from [10.154.208.144] ([10.154.208.144])
        by rcdn-core-11.cisco.com (8.15.2/8.15.2) with ESMTP id w9TL8ZqX015061;
        Mon, 29 Oct 2018 21:08:36 GMT
Subject: Re: [PATCH v4] kernel/signal: Signal-based pre-coredump notification
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian@brauner.io>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Roman Gushchin <guro@fb.com>,
        Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        "Victor Kamensky (kamensky)" <kamensky@cisco.com>,
        xe-linux-external@cisco.com, Stefan Strogin <sstrogin@cisco.com>,
        Enke Chen <enkechen@cisco.com>
References: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
 <458c04d8-d189-4a26-729a-bb1d1d751534@cisco.com>
 <7741efa7-a3f8-62a1-ba52-613883164643@cisco.com>
 <84460a77-a111-404e-4bad-88104a6e246e@cisco.com>
 <20181026082812.GA10581@redhat.com>
 <21f678a8-4001-df36-c26e-e96cf203b1b1@cisco.com>
 <20181029111804.GA24820@redhat.com>
From:   Enke Chen <enkechen@cisco.com>
Message-ID: <634f9518-c742-16f0-84f4-90943af6aed2@cisco.com>
Date:   Mon, 29 Oct 2018 14:08:34 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181029111804.GA24820@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.154.208.144, [10.154.208.144]
X-Outbound-Node: rcdn-core-11.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Oleg:

Yes, it should be the "real_parent" that is more interested in the notification.
Will revert back.

+static void do_notify_parent_predump(void)
+{
+	struct task_struct *parent;
+	int sig;
+
+	rcu_read_lock();
+	parent = rcu_dereference(current->real_parent);
+	sig = parent->signal->predump_signal;
+	if (sig != 0)
+		do_send_sig_info(sig, SEND_SIG_NOINFO, parent, PIDTYPE_TGID);
+	rcu_read_unlock();
+}

Thanks.  -- Enke

On 10/29/18 4:18 AM, Oleg Nesterov wrote:
> Hi,
> 
> On 10/26, Enke Chen wrote:
>>
>> This is really a good idea given that "parent" is declared as RCU-protected.
>> Just a bit odd, though, that the "parent" has not been accessed this way in
>> the code base.
> 
> It is acccessed when possible,
> 
>> So just to confirm: the revised code would look like the following:
>>
>> static void do_notify_parent_predump(void)
>> {
>>         struct task_struct *parent;
>>         int sig;
>>
>>         rcu_read_lock();
>>         parent = rcu_dereference(current->parent);
>>         sig = parent->signal->predump_signal;
>>         if (sig != 0)
>>                 do_send_sig_info(sig, SEND_SIG_NOINFO, parent, PIDTYPE_TGID);
>>         rcu_read_unlock();
>> }
> 
> Yes, this is what I meant.
> 
> But I still think do_notify_parent_predump() should notify ->real_parent,
> not ->parent.
> 
> Oleg.
> 
