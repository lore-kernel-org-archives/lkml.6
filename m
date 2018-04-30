Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754358AbeD3PGi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 11:06:38 -0400
Received: from forward1p.cmail.yandex.net ([77.88.31.16]:58536 "EHLO
        forward1p.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753691AbeD3PGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 11:06:37 -0400
Authentication-Results: mxback12g.mail.yandex.net; dkim=pass header.i=@yandex.ru
From: Evgeniy Polyakov <zbr@ioremap.net>
Envelope-From: drustafa@yandex.ru
To: Stefan Strogin <stefan.strogin@gmail.com>,
        Jesper Derehag <jderehag@hotmail.com>,
        David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xe-linux-external@cisco.com" <xe-linux-external@cisco.com>,
        "matt.helsley@gmail.com" <matt.helsley@gmail.com>
References: <20180329141247.20943-1-sstrogin@cisco.com>
         <20180330.125921.653839794312978457.davem@davemloft.net>
         <7d976488-6375-b3a8-e9d7-dc86b4c51b86@cisco.com>
         <DB6P190MB0389513E240BD8ECEE575DB4DDBB0@DB6P190MB0389.EURP190.PROD.OUTLOOK.COM> <32f14672-5715-3e21-ba85-b27dc8d2c6b0@gmail.com>
Subject: Re: [PATCH] connector: add parent pid and tgid to coredump and exit events
MIME-Version: 1.0
Message-Id: <4667631525100490@web38o.yandex.ru>
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Mon, 30 Apr 2018 18:01:30 +0300
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan, hi

Sorry for delay.

26.04.2018, 15:04, "Stefan Strogin" <stefan.strogin@gmail.com>:
> Hi David, Evgeniy,
>
> Sorry to bother you, but could you please comment about the UAPI change and the patch?

With 4-bytes pid_t everything looks fine, and I do not know arch where pid is larger currently, so it looks safe.

David, please pull it into your tree, or should it go via different path?

Acked-by: Evgeniy Polyakov <zbr@ioremap.net>


>>  I don't see how it breaks UAPI. The point is that structures
>>  coredump_proc_event and exit_proc_event are members of *union*
>>  event_data, thus position of the existing data in the structure is
>>  unchanged. Furthermore, this change won't increase size of struct
>>  proc_event, because comm_proc_event (also a member of event_data) is
>>  of bigger size than the changed structures.
>>
>>  If I'm wrong, could you please explain what exactly will the change
>>  break in UAPI?
>>
>>  On 30/03/18 19:59, David Miller wrote:
>>>  From: Stefan Strogin <sstrogin@cisco.com>
>>>  Date: Thu, 29 Mar 2018 17:12:47 +0300
>>>
>>>>  diff --git a/include/uapi/linux/cn_proc.h b/include/uapi/linux/cn_proc.h
>>>>  index 68ff25414700..db210625cee8 100644
>>>>  --- a/include/uapi/linux/cn_proc.h
>>>>  +++ b/include/uapi/linux/cn_proc.h
>>>>  @@ -116,12 +116,16 @@ struct proc_event {
>>>>               struct coredump_proc_event {
>>>>                       __kernel_pid_t process_pid;
>>>>                       __kernel_pid_t process_tgid;
>>>>  + __kernel_pid_t parent_pid;
>>>>  + __kernel_pid_t parent_tgid;
>>>>               } coredump;
>>>>
>>>>               struct exit_proc_event {
>>>>                       __kernel_pid_t process_pid;
>>>>                       __kernel_pid_t process_tgid;
>>>>                       __u32 exit_code, exit_signal;
>>>>  + __kernel_pid_t parent_pid;
>>>>  + __kernel_pid_t parent_tgid;
>>>>               } exit;
>>>>
>>>>       } event_data;
>>>
>>>  I don't think you can add these members without breaking UAPI.
