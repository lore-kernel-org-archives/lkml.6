Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754094AbeDYNWc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 09:22:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55314 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752722AbeDYNWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 09:22:31 -0400
Date: Wed, 25 Apr 2018 15:22:28 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
        Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, David.Panariti@amd.com,
        ebiederm@xmission.com, Alexander.Deucher@amd.com,
        akpm@linux-foundation.org, Christian.Koenig@amd.com
Subject: Re: [PATCH 2/3] drm/scheduler: Don't call wait_event_killable for
 signaled process.
Message-ID: <20180425132228.GC7592@redhat.com>
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
 <1524583836-12130-3-git-send-email-andrey.grodzovsky@amd.com>
 <7313704c-0693-0bb9-8818-99cd2b7c0ca0@daenzer.net>
 <20180424194418.GE25142@phenom.ffwll.local>
 <aa2d8587-651e-2c24-a673-4682e7035a8f@amd.com>
 <20180424214027.GG25142@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424214027.GG25142@phenom.ffwll.local>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/24, Daniel Vetter wrote:
>
> wait_event_killabel doesn't check for fatal_signal_pending before calling
> schedule, so definitely has a nice race there.

This is fine. See the signal_pending_state() check in __schedule().

And this doesn't differ from wait_event_interruptible(), it too doesn't
check signal_pending(), we rely on schedule() which must not block if the
caller is signalled/killed.

The problem is that it is not clear what should fatal_signal_pending() or
even signal_pending() mean after exit_signals().

Oleg.
