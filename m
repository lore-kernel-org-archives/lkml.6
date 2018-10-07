Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA44C65C1B
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 17:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99DFB206B2
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 17:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="lSNc9w/q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99DFB206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbeJHAe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 20:34:59 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:49653 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727383AbeJHAe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 20:34:58 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 8d2dd9b0;
        Sun, 7 Oct 2018 17:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=ZvstspmGhTn0kppU5KeTdAScAz8=; b=lSNc9w
        /q+qLTSPf6dFf+gw/9MYN02KR9mBgWqpOoS/Wx3ICz5cjWR+ECWrneUaQFVH6qAO
        yLD1/uECbM4y92c/ZwTxOQ32upXUYqwvCIUhJjBsuC/te1Rmz8/E+/JuFk1Wub29
        uZlPip+9QBeRagxG6U4dDDLrCxZH+OYcjhW0w2KjRjXUx4BgJzZfrXi4ci48ux4L
        oCN03/QSwcyF2h0GgzYtJPA7aFCHR+ZpfYTU299AhDZWyz9PRwSPsr+tWTc69t4s
        2aaS31bP1p1gQaFM2mAluU75giwdvM8p9r3Zsmoqh+a+Sjux3raam5bSYYt20HvK
        EQX6Nolm+XllpZmg==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 03738a81 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Sun, 7 Oct 2018 17:26:18 +0000 (UTC)
Received: by mail-oi1-f178.google.com with SMTP id w81-v6so14070166oiw.9;
        Sun, 07 Oct 2018 10:26:59 -0700 (PDT)
X-Gm-Message-State: ABuFfoi74aI9VyuZkd4yY9vzyJCypiWBAMXfCjZqX0TQUkn1JrInyn0K
        1nEFRl40p7xNpsaV3WiONCbZZcVM5tNGAJh2bY8=
X-Google-Smtp-Source: ACcGV637PfNIeKSXEGuhcc2o4vuGyau5jZ230O3RzT6jH9qGzzeNe4VN6qJWJlB3VEG+jq3hVpfBY4O7iQyZy9qj6kY=
X-Received: by 2002:aca:b04:: with SMTP id 4-v6mr3287340oil.192.1538933218744;
 Sun, 07 Oct 2018 10:26:58 -0700 (PDT)
MIME-Version: 1.0
References: <20181006025709.4019-1-Jason@zx2c4.com> <20181006025709.4019-29-Jason@zx2c4.com>
 <20181006065819.GD3061@nanopsycho.orion>
In-Reply-To: <20181006065819.GD3061@nanopsycho.orion>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sun, 7 Oct 2018 19:26:47 +0200
X-Gmail-Original-Message-ID: <CAHmME9pKvUOaAHhe7gb3yH4jdkdTtLv+gUqdnh3bJZcN776UWQ@mail.gmail.com>
Message-ID: <CAHmME9pKvUOaAHhe7gb3yH4jdkdTtLv+gUqdnh3bJZcN776UWQ@mail.gmail.com>
Subject: Re: [PATCH net-next v7 28/28] net: WireGuard secure network tunnel
To:     =?UTF-8?B?SmnFmcOtIFDDrXJrbw==?= <jiri@resnulli.us>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Sat, Oct 6, 2018 at 9:03 AM Jiri Pirko <jiri@resnulli.us> wrote:
> >+
> >+      wg->incoming_handshakes_worker =
> >+              wg_packet_alloc_percpu_multicore_worker(
> >+                              wg_packet_handshake_receive_worker, wg);
> >+      if (!wg->incoming_handshakes_worker)
> >+              goto error_2;
>
>
> Please consider renaming the label to "what went wrong". In this case,
> it would be "err_alloc_worker".
>
>
> >+
> >+      wg->handshake_receive_wq = alloc_workqueue("wg-kex-%s",
> >+                      WQ_CPU_INTENSIVE | WQ_FREEZABLE, 0, dev->name);
> >+      if (!wg->handshake_receive_wq)
> >+              goto error_3;
> >+
> >+      wg->handshake_send_wq = alloc_workqueue("wg-kex-%s",
> >+                      WQ_UNBOUND | WQ_FREEZABLE, 0, dev->name);
> >+      if (!wg->handshake_send_wq)
> >+              goto error_4;
> >+
> >+      wg->packet_crypt_wq = alloc_workqueue("wg-crypt-%s",
> >+                      WQ_CPU_INTENSIVE | WQ_MEM_RECLAIM, 0, dev->name);
> >+      if (!wg->packet_crypt_wq)
> >+              goto error_5;
> >+
> >+      if (wg_packet_queue_init(&wg->encrypt_queue, wg_packet_encrypt_worker,
> >+                               true, MAX_QUEUED_PACKETS) < 0)
>
> You need to have "int err" and always in cases like this to do:
> err = wg_packet_queue_init()
> if (err)
>         goto err_*
>
>
> >+              goto error_6;
> >+
> >+      if (wg_packet_queue_init(&wg->decrypt_queue, wg_packet_decrypt_worker,
> >+                               true, MAX_QUEUED_PACKETS) < 0)
> >+              goto error_7;
> >+
> >+      ret = wg_ratelimiter_init();
> >+      if (ret < 0)
> >+              goto error_8;
> >+
> >+      ret = register_netdevice(dev);
> >+      if (ret < 0)
> >+              goto error_9;
> >+
> >+      list_add(&wg->device_list, &device_list);
> >+
> >+      /* We wait until the end to assign priv_destructor, so that
> >+       * register_netdevice doesn't call it for us if it fails.
> >+       */
> >+      dev->priv_destructor = destruct;
> >+
> >+      pr_debug("%s: Interface created\n", dev->name);
> >+      return ret;
> >+
> >+error_9:
> >+      wg_ratelimiter_uninit();
> >+error_8:
> >+      wg_packet_queue_free(&wg->decrypt_queue, true);
> >+error_7:
> >+      wg_packet_queue_free(&wg->encrypt_queue, true);
> >+error_6:
> >+      destroy_workqueue(wg->packet_crypt_wq);
> >+error_5:
> >+      destroy_workqueue(wg->handshake_send_wq);
> >+error_4:
> >+      destroy_workqueue(wg->handshake_receive_wq);
> >+error_3:
> >+      free_percpu(wg->incoming_handshakes_worker);
> >+error_2:
> >+      free_percpu(dev->tstats);
> >+error_1:
> >+      return ret;
> >+}

I'll change away from using error_9,8,7,6,5,4,3,2,1 because of your
suggestion -- and because it's the norm in the kernel to use real
names. But, I would be interested in your opinion on the numerical
errors' reasoning for existing in the first place. The idea was that
with so many different failure cases that need to cascade in the
correct order, it's much easier to visually inspect that it's been
done right by observing up top 1,2,3,4,5,6,7,8,9 and at the bottom
9,8,7,6,5,4,3,2,1, rather than having to store in my brain's limited
stack space what each name pertains to and keep track of the ordering
and such. In light of that, do you still think that following the
convention of textual error labels is a good match here? Again, I'm
changing this for v8, but I am nonetheless curious about what you
think.

Jason
