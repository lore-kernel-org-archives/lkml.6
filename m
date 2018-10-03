Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28EDC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 16:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 989292098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 16:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UlSXJFwl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 989292098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbeJCXEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 19:04:39 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41119 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbeJCXEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 19:04:38 -0400
Received: by mail-oi1-f195.google.com with SMTP id l197-v6so4997020oib.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 09:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=LexTFq1YQNlISjLro2ViyTuiFDAdqCkOsmEEHY4Plgc=;
        b=UlSXJFwlPnzbIU8G0wc0D6P4uVXvXwNHhGzT2jxjiCv3vbnq5EwJN14yE43CuMGi0P
         q2WgI0D31jAYejhjvw6zMwuuwllo5XVGfn+bKhKlHAxMhvbNpEtrC5GyAJvrMK71Idye
         JgevMhvT8DXg1Bgb60DQVKtofDsqLLq0IVr9J+R2WSIM56dA71m02gcm4RWgqSC1ypPV
         wj4SrYD8T7tSuzmvM2XOzzXz1sCZsIRWD7Q2Wbw+avh6CB9vwZ8JqFeOPJL7J9jsXoO8
         hWsKkFrKj0jmpvrh+j6ofNKp5iVErDpuL8V8Vu4Hj5kHkqmaxjTzk/OUCltjyD+AM3Yu
         IyAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=LexTFq1YQNlISjLro2ViyTuiFDAdqCkOsmEEHY4Plgc=;
        b=Jh9AZake+F5SySmPNXcblsoA21TNKufc7DlMkZyRyI3Au+fF41YvXSs+vKb2n3yMUp
         ry7yzS+QxMNCModHYFcRw0cBbKsBV5inx0cMKuT2x3CjIaPjMkJComPV1BV6gRPJlk7V
         aXgeAR1ozP4eAw3M222KwwJCiYopZkWhoJ8eGjQi0WgRqs39kdIC1nFCSF1NIr+Z3xYd
         wo0US8qYPqXVgLkW8muEdWctopGRoVmAjM86ybje8HSiO++s2Li6KnvOgSmlhJdH7XhG
         hbVZES0e6QeU1OzN1f5I/DWl/ZlL7QdLztUzneCRXSukEFkGGu46lkAqIOVYxRi/9XFz
         Ya9g==
X-Gm-Message-State: ABuFfog8SQKzMmgM+jGWiTZW6UzuFWJCX6Vdt9DxkrhCOM77eLdkHdkK
        /URoAVNb1J1mr8I2YbvxZjoU44QA/49dQH0J79VYyw==
X-Google-Smtp-Source: ACcGV600+nO3jkYGf2N/VG+Gx960Jk+JJP9Ln2qMAPUWcR8vedc03gKWXswkZauSVbUrKoN9xBaiB33UT9c4ZYa0MPQ=
X-Received: by 2002:aca:aa4f:: with SMTP id t76-v6mr1122680oie.253.1538583334515;
 Wed, 03 Oct 2018 09:15:34 -0700 (PDT)
MIME-Version: 1.0
From:   Jann Horn <jannh@google.com>
Date:   Wed, 3 Oct 2018 18:15:08 +0200
Message-ID: <CAG48ez0Q3BaFsA_FUs1ZCAMRZtXkq5o_VCbU8CgTEVwa2HRZfQ@mail.gmail.com>
Subject: BPF: RCU use-after-reallocation of hash table elements?
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Network Development <netdev@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        linux-man <linux-man@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Note: I haven't tested any of this; feel free to tell me that I've
completely misunderstood how all this works.

The BPF manpage, at the moment, states about BPF hash tables:

       BPF_MAP_TYPE_HASH
              Hash-table maps have the following characteristics:

              *  Maps are created and destroyed by user-space programs.
                 Both user-space and eBPF programs can perform lookup,
                 update, and delete operations.

              *  The kernel takes care of allocating and freeing key/value
                 pairs.

              *  The map_update_elem() helper will fail to insert new ele=
=E2=80=90
                 ment when the max_entries limit is reached.  (This ensures
                 that eBPF programs cannot exhaust memory.)

              *  map_update_elem() replaces existing elements atomically.

              Hash-table maps are optimized for speed of lookup.

This documentation claims that elements are replaced "atomically", and
that the kernel "takes care of allocating and freeing key/value
pairs". But as far as I can tell, that's not quite the whole story
least since commit 6c90598174322b8888029e40dd84a4eb01f56afe (first in
4.6).

Unless a BPF hash table is created with the (undocumented) flag
BPF_F_NO_PREALLOC, the kernel now actually pre-allocates the hash
table elements. Hash table elements can be freed and reused for new
allocations (!) without waiting for an RCU grace period: Freed
elements are immediately pushed on the percpu freelist, and can be
immediately reused from there. The most obvious consequence of this is
that if a BPF program looks up a hash table entry and then reads the
value, the value can be replaced with a new value in between. A more
subtle consequence is that BPF map lookups can return false-positive
results: If the first half of the lookup key matches the old key, and
the second half of the lookup key matches the new key, then a BPF map
lookup can return a false-positive result, as far as I can tell.

If what I'm saying is correct, I'm not sure what the best fix is.

Add a grace period when freeing hash map entries, and add a new -EBUSY
return value for attempts to create hash map entries when all free
entries are waiting for the end of an RCU grace period?

Add a grace period when freeing hash map entries, and use
rcu_synchronize() when inserting BPF hashmap entries from userspace
and all free entries are waiting for RCU? But that still leaves the
bpf_map_update_elem_proto helper that can be called from BPF.
Deprecate that helper for access to hash maps?

Document the race, and advise people who use BPF for
non-performance-tracing purposes (where occasional false positives
actually matter) to use BPF_F_NO_PREALLOC?

Add some sort of sequence lock to BPF (yuck)?
