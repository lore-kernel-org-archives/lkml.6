Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932953AbeD0Pi7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 11:38:59 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:42891 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932455AbeD0Pi5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 11:38:57 -0400
X-Google-Smtp-Source: AB8JxZqkeBXBpe1GsarEkeINS3odtNhjQAlONahZXazNsei3Fectg7HoiMwwgJfVn/FSHjKhYND/WZrKF6D4PxgJF/k=
MIME-Version: 1.0
In-Reply-To: <20180427000013.GH5965@thunk.org>
References: <d92d049a-8810-a765-d57a-2a7a805fadaf@gmail.com>
 <20180426050056.GF18803@thunk.org> <b902d9f5-300e-2611-289d-f6d49dd43f11@gmail.com>
 <20180426073255.GH18803@thunk.org> <b6aa3fac-a768-e27d-3070-00d929ebc245@gmail.com>
 <20180426192524.GD5965@thunk.org> <2add15cb-2113-0504-a732-81255ea61bf5@gmail.com>
 <20180426204748.GA7540@gmail.com> <20180427000013.GH5965@thunk.org>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Fri, 27 Apr 2018 17:38:52 +0200
X-Gmail-Original-Message-ID: <CAHmME9oVRULStf1ff+OUJLyf7GMxUTPrJebF5pxxLO7Sn2tzow@mail.gmail.com>
Message-ID: <CAHmME9oVRULStf1ff+OUJLyf7GMxUTPrJebF5pxxLO7Sn2tzow@mail.gmail.com>
Subject: Re: Linux messages full of `random: get_random_u32 called from`
To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Christian Brauner <christian.brauner@canonical.com>,
        Sultan Alsawaf <sultanxda@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ted,

Please correct me if I'm wrong, but my present understanding of this
is that crng readiness used to be broken, meaning people would have a
seeded rng without it actually being seeded. You fixed this bug, and
now people are discovering that they don't have crng readiness during
a late stage of their init, which is breaking all sorts of entirely
reasonable and widely deployed userspaces.

You could argue that those userspaces were "only designed for machines
that have enough [by what measure?] boot time entropy", but obviously
they didn't have that in mind. And now here we have an example of an
ordinary x86 machine -- not some weird embedded device -- hitting
these issues. I'd suspect that the problem here isn't one that we can
exclusively punt onto userspace.

Sultan mentioned that his machine actually does trigger large
quantities of interrupts. Is it possible that the entropy gathering
algorithm has some issues, and Sultan's report points to a real bug
here? Considering the crng readiness state hasn't been working until
your recent fix, I suspect the actual entropy gathering code probably
hasn't prompted too many bug reports, until now that is.

Jason
