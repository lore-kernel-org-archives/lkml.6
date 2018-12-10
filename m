Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3975C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7646820855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:11:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7646820855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbeLJOLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 09:11:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56703 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727197AbeLJOLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 09:11:11 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9529D307D866;
        Mon, 10 Dec 2018 14:11:10 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.131])
        by smtp.corp.redhat.com (Postfix) with SMTP id 807ED600D6;
        Mon, 10 Dec 2018 14:11:08 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 10 Dec 2018 15:11:10 +0100 (CET)
Date:   Mon, 10 Dec 2018 15:11:07 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, linux-api@vger.kernel.org,
        strace-devel@lists.strace.io, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 24/25] ptrace: add PTRACE_GET_SYSCALL_INFO request
Message-ID: <20181210141107.GB4177@redhat.com>
References: <20181210042352.GA6092@altlinux.org>
 <20181210043126.GX6131@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210043126.GX6131@altlinux.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Mon, 10 Dec 2018 14:11:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10, Dmitry V. Levin wrote:
>
> +struct ptrace_syscall_info {
> +	__u8 op;	/* PTRACE_SYSCALL_INFO_* */
> +	__u8 __pad0[3];
> +	__u32 arch;
> +	__u64 instruction_pointer;
> +	__u64 stack_pointer;
> +	__u64 frame_pointer;
> +	union {
> +		struct {
> +			__u64 nr;
> +			__u64 args[6];
> +		} entry;
> +		struct {
> +			__s64 rval;
> +			__u8 is_error;
> +			__u8 __pad1[7];
> +		} exit;
> +		struct {
> +			__u64 nr;
> +			__u64 args[6];
> +			__u32 ret_data;
> +			__u8 __pad2[4];
> +		} seccomp;
> +	};
> +};

Could you explain why ptrace_syscall_info needs __pad{0,1,2} ? I simply can't
understand why...

Otherwise the patch looks good to me. I am not going to discuss the API and
data layout, I am fine with anything which suits user-space needs.

I think the patch is technically correct, feel free to add

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

