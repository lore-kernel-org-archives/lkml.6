Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752788AbeCaAUR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 20:20:17 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:37454 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752384AbeCaAUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 20:20:15 -0400
X-Google-Smtp-Source: AIpwx49a8QSM3FQpm86dn71OTKU3hLj1uCpN1L/Li7MIhATkq84rWjHtWDax/ZFBKPzcpYnhKtLAzVf82j8jmnZCfFw=
MIME-Version: 1.0
In-Reply-To: <CAN05THTrte19yRdyAOHvcjhxmOW=auh=z5nvVXsqcLxbmYn7Dg@mail.gmail.com>
References: <20180330221636.32512-1-longli@linuxonhyperv.com> <CAN05THTrte19yRdyAOHvcjhxmOW=auh=z5nvVXsqcLxbmYn7Dg@mail.gmail.com>
From: Steve French <smfrench@gmail.com>
Date: Fri, 30 Mar 2018 19:19:54 -0500
Message-ID: <CAH2r5msBv0tUjitg64fBaitC83_8i6iGOzzmjhE4HxEUtBe6hQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] cifs: smbd: avoid reconnect lockup
To: ronnie sahlberg <ronniesahlberg@gmail.com>
Cc: Long Li <longli@microsoft.com>, Steve French <sfrench@samba.org>,
        linux-cifs <linux-cifs@vger.kernel.org>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

merged into cifs-2.6.git for-next

added cc:stable

On Fri, Mar 30, 2018 at 5:23 PM, ronnie sahlberg
<ronniesahlberg@gmail.com> wrote:
> Looks good to me (both patches)
>
> Reviewed-by: Ronnie Sahlberg <lsahlber@redhat.com>
>
> On Sat, Mar 31, 2018 at 8:16 AM, Long Li <longli@linuxonhyperv.com> wrote:
>> From: Long Li <longli@microsoft.com>
>>
>> During transport reconnect, other processes may have registered memory
>> and blocked on transport. This creates a deadlock situation because the
>> transport resources can't be freed, and reconnect is blocked.
>>
>> Fix this by returning to upper layer on timeout. Before returning,
>> transport status is set to reconnecting so other processes will release
>> memory registration resources.
>>
>> Upper layer will retry the reconnect. This is not in fast I/O path so
>> setting the timeout to 5 seconds.
>>
>> Signed-off-by: Long Li <longli@microsoft.com>
>> ---
>>  fs/cifs/smbdirect.c | 12 ++++++++----
>>  1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/cifs/smbdirect.c b/fs/cifs/smbdirect.c
>> index 5aa0b54..3f7883e 100644
>> --- a/fs/cifs/smbdirect.c
>> +++ b/fs/cifs/smbdirect.c
>> @@ -1498,8 +1498,8 @@ int smbd_reconnect(struct TCP_Server_Info *server)
>>         log_rdma_event(INFO, "reconnecting rdma session\n");
>>
>>         if (!server->smbd_conn) {
>> -               log_rdma_event(ERR, "rdma session already destroyed\n");
>> -               return -EINVAL;
>> +               log_rdma_event(INFO, "rdma session already destroyed\n");
>> +               goto create_conn;
>>         }
>>
>>         /*
>> @@ -1512,15 +1512,19 @@ int smbd_reconnect(struct TCP_Server_Info *server)
>>         }
>>
>>         /* wait until the transport is destroyed */
>> -       wait_event(server->smbd_conn->wait_destroy,
>> -               server->smbd_conn->transport_status == SMBD_DESTROYED);
>> +       if (!wait_event_timeout(server->smbd_conn->wait_destroy,
>> +               server->smbd_conn->transport_status == SMBD_DESTROYED, 5*HZ))
>> +               return -EAGAIN;
>>
>>         destroy_workqueue(server->smbd_conn->workqueue);
>>         kfree(server->smbd_conn);
>>
>> +create_conn:
>>         log_rdma_event(INFO, "creating rdma session\n");
>>         server->smbd_conn = smbd_get_connection(
>>                 server, (struct sockaddr *) &server->dstaddr);
>> +       log_rdma_event(INFO, "created rdma session info=%p\n",
>> +               server->smbd_conn);
>>
>>         return server->smbd_conn ? 0 : -ENOENT;
>>  }
>> --
>> 2.7.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-cifs" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-cifs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Thanks,

Steve
