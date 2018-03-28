Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753447AbeC1W6w (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 18:58:52 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:55736 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752883AbeC1W6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 18:58:50 -0400
X-Google-Smtp-Source: AIpwx48CE9hasvTnVBdjIu4135oYtVFaPaMRy0sQ4DVBr5E2iz6l/BL5ETj6S/0kvXbRbW0/5dZwNata898JMICkJIM=
MIME-Version: 1.0
In-Reply-To: <87woxv3m0g.fsf@notabene.neil.brown.name>
References: <20180328160009.29633-1-agruenba@redhat.com> <87woxv3m0g.fsf@notabene.neil.brown.name>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 29 Mar 2018 00:58:49 +0200
Message-ID: <CAHc6FU4Wb-QvRC_VN8iay8YcikBBvVwYLf5JfEy_jAm4Z+Md8A@mail.gmail.com>
Subject: Re: [PATCH] gfs2: Stop using rhashtable_walk_peek
To: NeilBrown <neilb@suse.com>
Cc: cluster-devel <cluster-devel@redhat.com>, netdev@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Tom Herbert <tom@quantonium.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 March 2018 at 23:53, NeilBrown <neilb@suse.com> wrote:
> Thank for this patch!
> The above looks a bit fragile to me.
> gfs2_glock_iter_next() (And hence gfs2_glock_seq_start()) will sometimes
> exit with gl_held true, and sometimes with it false.
> gfs2_glock_seq_stop() assumes that it is false.
> Normally gfs2_glock_seq_next() will normally be called between these
> two and will clear gl_held, but I don't think there is a hard guarantee
> of that.
> Maybe we should always 'put' gi->gl in iter_next if gl_held??

Another problem is that gfs2_glock_seq_stop only does a lockref_get
which is not allowed because the lockref may have been marked dead in
the meantime. We'll have to take a reference on each lock in
gfs2_glock_iter_next instead. Revised patch to follow tomorrow.

Thanks,
Andreas
