Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932128AbeDZNpJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 09:45:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51954 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932091AbeDZNpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 09:45:04 -0400
Subject: Re: [PATCH v4 0/1] Add livepatch kselftests
From: Joe Lawrence <joe.lawrence@redhat.com>
To: live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Ye Xiaolong <xiaolong.ye@intel.com>, Philip Li <philip.li@intel.com>
References: <1524680930-28168-1-git-send-email-joe.lawrence@redhat.com>
Organization: Red Hat
Message-ID: <148c3baf-ab6f-c1f2-2911-79e5c8b361bd@redhat.com>
Date: Thu, 26 Apr 2018 09:45:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <1524680930-28168-1-git-send-email-joe.lawrence@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On 04/25/2018 02:28 PM, Joe Lawrence wrote:

> [ ... snip ... ]
> 
> base-commit: 0adb32858b0bddf4ada5f364a84ed60b196dbcda
> prerequisite-patch-id: 5ed747c1a89a5dc4bba08186e21f927d7f3bf049
> prerequisite-patch-id: e9800288b71a9f339ea066e58d9ef70dece67083
> prerequisite-patch-id: 415f2e190b1b50142c78f2940c7b8dd39b5321a0
> prerequisite-patch-id: d229d9cf08af087e0a758d9df1da467103c2c200
> prerequisite-patch-id: b8c7ef99b13c6b321cba5e8919ed0b3e29f213e9
> prerequisite-patch-id: 4e10c0d08f151b18310fe0b1e5013d62db94cfeb
> prerequisite-patch-id: 33046b190c114d202f3a52e0e274dbb2b1907a4c
> prerequisite-patch-id: 6978944a725756317dd4e005d479b6101784aaf0
> prerequisite-patch-id: cce9d3c7e1ae8887f387ca9e072552dc63479749
> prerequisite-patch-id: c44ccc5dd7b1be6fe2b1f32ca6abde1da73fae79
> 

Hi kbuild test robot folks,

I attempted to use the --base option with git format-patch as suggested
by Philip, but the bot still sent me mail (addressed only to myself and
cc'd kbuild-all@01.org) about build test ERRORs against the wrong base:

> [auto build test ERROR on v4.16]
> [also build test ERROR on next-20180424]
> [cannot apply to linus/master jikos-livepatching/for-next]

I'm assuming operator error :(  Here's a summary of my workflow:

* Save an .mbox of the entire base patchset, as posted to the
live-patching list:

  https://lkml.org/lkml/2018/3/23/665

* Create a "base" branch and apply the mbox:

  % git checkout -b test_base v4.16
  Switched to a new branch 'test_base'

  % git am /tmp/pm.mbox
  Applying: livepatch: Use lists to manage patches, objects and functions
  Applying: livepatch: Free only structures with initialized kobject
  Applying: livepatch: Add atomic replace
  Applying: livepatch: Add an extra flag to distinguish registered   patches
  Applying: livepatch: Remove replaced patches from the stack
  Applying: livepatch: Remove Nop structures when unused
  Applying: livepatch: Allow to replace even disabled patches
  Applying: livepatch: Atomic replace and cumulative patches documentation

* Create a new dev branch from the base, make a trivial change and commit:

  % git checkout -b test_branch test_base
  % sed -i 's/^EXTRAVERSION =/EXTRAVERSION = .test/' Makefile
  % git commit Makefile -m 'test commit'

* Create .patch files with --base:

  % git format-patch --base=v4.16 -1 --cover-letter
  % grep -e '^base-commit' -e 'prereq' 0000-cover-letter.patch
  base-commit: 0adb32858b0bddf4ada5f364a84ed60b196dbcda
  prerequisite-patch-id: 5ed747c1a89a5dc4bba08186e21f927d7f3bf049
  prerequisite-patch-id: e9800288b71a9f339ea066e58d9ef70dece67083
  prerequisite-patch-id: 415f2e190b1b50142c78f2940c7b8dd39b5321a0
  prerequisite-patch-id: d229d9cf08af087e0a758d9df1da467103c2c200
  prerequisite-patch-id: b8c7ef99b13c6b321cba5e8919ed0b3e29f213e9
  prerequisite-patch-id: 4e10c0d08f151b18310fe0b1e5013d62db94cfeb
  prerequisite-patch-id: 33046b190c114d202f3a52e0e274dbb2b1907a4c
  prerequisite-patch-id: 6978944a725756317dd4e005d479b6101784aaf0

I notice that these patch-ids are only added to the cover-letter... do I
need to force them each individual patch as well?  /confused

Thanks,

-- Joe
