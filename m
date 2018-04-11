Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752796AbeDKJaD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 05:30:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:33043 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752368AbeDKJ36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 05:29:58 -0400
Date: Wed, 11 Apr 2018 11:29:56 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: Petr Mladek <pmladek@suse.com>
cc: Jiri Kosina <jikos@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Nicolai Stange <nstange@suse.de>, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] livepatch: Initialize shadow variables safely by
 a custom callback
In-Reply-To: <20180405122315.29065-2-pmladek@suse.com>
Message-ID: <alpine.LSU.2.21.1804111030120.28885@pobox.suse.cz>
References: <20180405122315.29065-1-pmladek@suse.com> <20180405122315.29065-2-pmladek@suse.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Apr 2018, Petr Mladek wrote:

> The existing API allows to pass a sample data to initialize the shadow
> data. It works well when the data are position independent. But it fails
> miserably when we need to set a pointer to the shadow structure itself.
> 
> Unfortunately, we might need to initialize the pointer surprisingly
> often because of struct list_head. It is even worse because the list
> might be hidden in other common structures, for example, struct mutex,
> struct wait_queue_head.
> 
> For example, this was needed to fix races in ALSA sequncer. It required

s/sequncer/sequencer/

> to add mutex into struct snd_seq_client. See commit b3defb791b26ea06
> ("ALSA: seq: Make ioctls race-free") and commit d15d662e89fc667b9
> ("ALSA: seq: Fix racy pool initializations")
> 
> This patch makes the API more safe. A custom constructor function and data
> are passed to klp_shadow_*alloc() functions instead of the sample data.
> 
> Note that ctor_data are not longer a template for shadow->data. It might

s/not longer/no longer/

> point to any data that might be necessary when the constructor is called.

Miroslav
