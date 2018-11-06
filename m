Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E9AC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04B9F2083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:05:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04B9F2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730489AbeKFWae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 17:30:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:52304 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729272AbeKFWae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 17:30:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5D181ACC1;
        Tue,  6 Nov 2018 13:05:25 +0000 (UTC)
Date:   Tue, 6 Nov 2018 14:05:24 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Daniel Colascione <dancol@google.com>
Cc:     linux-kernel@vger.kernel.org, rppt@linux.ibm.com,
        timmurray@google.com, joelaf@google.com, surenb@google.com,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
        Prashant Dhamdhere <pdhamdhe@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2] Document /proc/pid PID reuse behavior
Message-ID: <20181106130524.GC2453@dhcp22.suse.cz>
References: <20181031150625.147369-1-dancol@google.com>
 <20181105132205.138695-1-dancol@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105132205.138695-1-dancol@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 05-11-18 13:22:05, Daniel Colascione wrote:
> State explicitly that holding a /proc/pid file descriptor open does
> not reserve the PID. Also note that in the event of PID reuse, these
> open file descriptors refer to the old, now-dead process, and not the
> new one that happens to be named the same numeric PID.

This sounds quite obvious otherwise anybody could simply DoS the system
by consuming all available pids. But I do not see any strong reason
against having that stated explicitly.

> Signed-off-by: Daniel Colascione <dancol@google.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  Documentation/filesystems/proc.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> Moved paragraphed to start of /proc/pid section; added signed-off-by.
> 
> diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
> index 12a5e6e693b6..0b14460f721d 100644
> --- a/Documentation/filesystems/proc.txt
> +++ b/Documentation/filesystems/proc.txt
> @@ -125,6 +125,13 @@ process running on the system, which is named after the process ID (PID).
>  The link  self  points  to  the  process reading the file system. Each process
>  subdirectory has the entries listed in Table 1-1.
>  
> +Note that an open a file descriptor to /proc/<pid> or to any of its
> +contained files or subdirectories does not prevent <pid> being reused
> +for some other process in the event that <pid> exits. Operations on
> +open /proc/<pid> file descriptors corresponding to dead processes
> +never act on any new process that the kernel may, through chance, have
> +also assigned the process ID <pid>. Instead, operations on these FDs
> +usually fail with ESRCH.
>  
>  Table 1-1: Process specific entries in /proc
>  ..............................................................................
> -- 
> 2.19.1.930.g4563a0d9d0-goog

-- 
Michal Hocko
SUSE Labs
