Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751913AbeDYKRT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 06:17:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59106 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751212AbeDYKRP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 06:17:15 -0400
Date: Wed, 25 Apr 2018 12:17:13 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: Re: [PATCH 0/3] bpf: Store/dump license string for loaded program
Message-ID: <20180425101713.GB3396@krava>
References: <20180423065927.23127-1-jolsa@kernel.org>
 <20180423201134.r56ts7usec4jjnbh@ast-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423201134.r56ts7usec4jjnbh@ast-mbp>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 02:11:36PM -0600, Alexei Starovoitov wrote:
> On Mon, Apr 23, 2018 at 08:59:24AM +0200, Jiri Olsa wrote:
> > hi,
> > sending the change to store and dump the license
> > info for loaded BPF programs. It's important for
> > us get the license info, when investigating on
> > screwed up machine.
> 
> hmm. boolean flag whether bpf prog is gpl or not
> is already exposed via bpf_prog_info.

hum, I can't see that (on bpf-next/master)
would the attached change be ok with you?

jirka


---
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index e6679393b687..2ce9c9d41c2b 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1062,6 +1062,7 @@ struct bpf_prog_info {
 	__u32 ifindex;
 	__u64 netns_dev;
 	__u64 netns_ino;
+	__u16 gpl_compatible:1;
 } __attribute__((aligned(8)));
 
 struct bpf_map_info {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index fe23dc5a3ec4..7bb4ff1c770a 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1914,6 +1914,7 @@ static int bpf_prog_get_info_by_fd(struct bpf_prog *prog,
 	info.load_time = prog->aux->load_time;
 	info.created_by_uid = from_kuid_munged(current_user_ns(),
 					       prog->aux->user->uid);
+	info.gpl_compatible = prog->gpl_compatible;
 
 	memcpy(info.tag, prog->tag, sizeof(prog->tag));
 	memcpy(info.name, prog->aux->name, sizeof(prog->aux->name));
