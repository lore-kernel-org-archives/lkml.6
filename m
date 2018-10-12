Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E51EC6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 21:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7DC120868
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 21:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EiZ592V3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7DC120868
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbeJMFAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 01:00:45 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:37596 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbeJMFAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 01:00:45 -0400
Received: by mail-wr1-f47.google.com with SMTP id y11-v6so14808110wrd.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 14:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Ky/hwcktm81qh6cVpdbTrJeL1bzyNIt4g7dMkNUjmuY=;
        b=EiZ592V3M8YCvv8yLdOkXjOkn8HMy/HNBRqw0RyLq1oxSSuLiktR4pKKUvMb9yAoRo
         dtn1maFkI9OiZt0/HLJ39W6qnw39mX4LV/97KWORIQWzweFeSXeTvFmEfd3kRcIcQjPM
         H6Ch7C+JQIvJToktehOEnu1ery7V2khixAE5uvK/3eYZVupS77eRvPVV05LHrUKJVAsy
         CiAbQbr8aq6CRB/aAPlM/tQfy2TccrwZe0fhDNWWKIDUKzt6Ow1kmY09FW3Z4rLzwbBk
         ZPj63L4to01P3v60BiyMfnT+o+LeEBFA4aC6gjVOsCWKc4x6NkzTN5ALReoYjq1I1S6T
         7F8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Ky/hwcktm81qh6cVpdbTrJeL1bzyNIt4g7dMkNUjmuY=;
        b=FON1EnGvPToflocBF9qQNJnGDQ5z855ixGpwgb5BQVboGp4dyEq92LOwJv0uQ+cfmD
         NiY4uROz561OJe5WdPrK1NCx4nn9tucUeroypHDrbHD6eygEQvPd8ebxkyQ2Mdd+LLW6
         wqt0kZmbkrDjDDy1z7vkTTQ+ZH7a004tMXGUgQKiEPXu9sHxg4vXlkyLSvjib9UgCXv8
         40XaqsizVm7roJMIOLU8Aegl2lnxfx+83mh6e8KbsQv7s2QwLnsPAB7oXar9nbOnRYOi
         a4b20gYrHL5uO7NaHwgTRrXcDL05OO2K5jD9NoZZi2y6AT4KmPl4iVR2HoJAwDQK3q4M
         Tm4Q==
X-Gm-Message-State: ABuFfojW0MgCfbgEIHU3SWo/pLJrkxU4h9sH3YN3Xs0dGU0WNy1lkenP
        DlzSmPm06JLdYP67TeD/HKzspZwxmmlLG9Y7a0WORjBIfK0=
X-Google-Smtp-Source: ACcGV61f+kDYLAJQVlmF9rblF+fotcHvRrAgHXZeY1SHEfOq0oqOs9rMxfFT0lCRBAxmkIklo9bCPj8dCCNe7Nn9z54=
X-Received: by 2002:adf:ed06:: with SMTP id a6-v6mr6194417wro.262.1539379580663;
 Fri, 12 Oct 2018 14:26:20 -0700 (PDT)
MIME-Version: 1.0
From:   Stephane Eranian <eranian@google.com>
Date:   Fri, 12 Oct 2018 14:26:09 -0700
Message-ID: <CABPqkBTEOwKrq6ZJo3W-rZQi56OWorWo3VcOTwV17QxZBckS0Q@mail.gmail.com>
Subject: [BUG] perf stat: hangs with -p and process completes
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am running into a perf stat issue with the -p option which allows you
to attach to a running process. If that process happens to terminate
while under monitoring
perf hangs in there and never terminates. The proper behavior would be to stop.
I can see the issue in that the attached process is not a child, so
wait() would not work.

To reproduce:
  $ sleep 10 &
  $ perf stat -p $!

doing the same with perf record works, so there is a solution to this problem.
