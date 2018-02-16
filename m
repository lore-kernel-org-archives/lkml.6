Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AH8x2277Zwugja/DV5v2yTs0AGE+HB7Dnf66bZ2Nhqwx6XZkMSpcZojXCsl/1564dKyiG+mWpmV6
ARC-Seal: i=1; a=rsa-sha256; t=1518786640; cv=none;
        d=google.com; s=arc-20160816;
        b=mxCglX4oPPRXnuf1rNMIszZVJ/aVVl+dk7XZeLAl4wS4q4mJHEllay0IetD2W0xxXD
         TdXHMW++gX0xZ95E2xobivr+FH9CNIaohClkhWP7zQuvxTrVzoAX2x9Yvp4Z4xFKVUrm
         6//099oyRB3g+jM9GA4veSt/TaNKeBNTnNYHtx5Ihhx/wa3KgprdkPfoNI3BjXb7YSGi
         8hhXjRrNLZqaNnc8vQGxwKW1vNCLBWSiV2AfZ+AO5YC1c1ipxV0KhI/GDQULoLRoqHq1
         SkTVK2Xjk4QMpwWuHAKoF47T4Ci/EmaTSp/8v55O9vurAZLjlM6hsruvBs4E/6VcUFTW
         Hgww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=gcgj2W6v6ItGeKu+hAOC+bfjmCbez858fdOi1gQ1OYM=;
        b=To/Lyb0wbLwZCmI3b/eZw8/NrKVn0my0hdCcsBdDr3I2XjHyucnkAc0DSwZbwsdWRb
         48KUYRcdClEts/s0YgkEKthSGgdF5VgT6y2DkjnmOdBF/oNueHiD+VOGAJle0If+lBzd
         2o+jY0xCtv9BnEJkYQdcUmw+5QWPirsiCzEbPscELcwne4hmCansCeAKxJGjJzjOOhmM
         I4XRo0DydLBcU7O/rm5N+EWr/j5MUdnsGC/x0ZsHRy9vIZxtUe2PKqOQDujSsTaPbJ4+
         ao5NOwRc+9mcYwfVo/NkNU76SI0NgumaGfiuxygDQUe/AMKUPK9fCVZJPWgEywpe/XU4
         jaBg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=YBSCf41q;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=YBSCf41q;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
MIME-Version: 1.0
In-Reply-To: <20180216091918.axu57tfsezzybeoa@gmail.com>
References: <20180215165920.8570-1-pasha.tatashin@oracle.com>
 <20180215165920.8570-6-pasha.tatashin@oracle.com> <20180216091918.axu57tfsezzybeoa@gmail.com>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Fri, 16 Feb 2018 08:09:15 -0500
X-Gmail-Original-Message-ID: <CAOAebxuwVqjbKuHfpNn9=YBR397pjK-QfF-Akh7UuoEfkW0PWw@mail.gmail.com>
Message-ID: <CAOAebxuwVqjbKuHfpNn9=YBR397pjK-QfF-Akh7UuoEfkW0PWw@mail.gmail.com>
Subject: Re: [v4 5/6] mm/memory_hotplug: don't read nid from struct page
 during hotplug
To: Ingo Molnar <mingo@kernel.org>
Cc: Steve Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Bharata B Rao <bharata@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, dan.j.williams@intel.com,
        kirill.shutemov@linux.intel.com, bhe@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8806 signatures=668672
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=372
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802160158
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592487103505854531?=
X-GMAIL-MSGID: =?utf-8?q?1592563221176281220?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> The namespace of all these memory range handling functions is horribly random,
> and I think now it got worse: we add an assumption that register_new_memory() is
> implicitly called as part of hotplugged memory (where things are pre-cleared) -
> but nothing in its naming suggests so.
>
> How about renaming it to hotplug_memory_register() or so?

Sure, I will rename it.

>
> With that change you can add:
>
>   Reviewed-by: Ingo Molnar <mingo@kernel.org>

Thank you,
Pavel
