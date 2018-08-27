Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBDBC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 15:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E25C9208B8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 15:27:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E25C9208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbeH0TOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 15:14:46 -0400
Received: from mail-qt0-f175.google.com ([209.85.216.175]:35467 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbeH0TOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 15:14:46 -0400
Received: by mail-qt0-f175.google.com with SMTP id f19-v6so17042076qtf.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 08:27:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ScWwjVzdzRaPnHICCwSrX8sjB5bfkjuV+2hB+EAY6fk=;
        b=RQxAJSn2J9qvLWL8SOrZ9itZEYQnIkL8V75q/jeH3LMRjH4aG57tcwFI4T5PU9wgdO
         biZmYRZClBynZ9fVDIKwYtlm09N/7Tc5sbAB5ngPftnLkQaNFeEw3MwvQxUqvGIIkgF7
         Arof3N2i957phWXvXy/8nhTUAeasNUC75htTkYdiwzjDoI7nvosToZXnpHUyGJtCDuDl
         y+TB6ef2mvl6lFxHHhg+H5V7fqd8VCWdVJBGZ7eMyHDVE7nU5aHQ2v8n814pvLHnOJ3I
         12UAu6P2COtOPofmvbes3cS+UOpwWTq7oHhsd9Zq6wCJgrZBhY20pimwHV2J8AXMkDXc
         5Tvw==
X-Gm-Message-State: APzg51DbYHIYVLOzXsScQE4BGXNHTLvL9GrUxA69/vELh4+shlJurq1o
        NTihwUA8HgoqA6e6rau+m5JN4A4Qp+p0gFn1a5q5lA==
X-Google-Smtp-Source: ANB0VdbnJpq0O7xQldtWD6YdHPYGWQ2WYJzDj/YbdOvYCNyjOb1kx0vvRxRd+iidjX+bg1NR/TZQV0v9AGDvgXHz8eg=
X-Received: by 2002:a0c:d647:: with SMTP id e7-v6mr13578879qvj.238.1535383661158;
 Mon, 27 Aug 2018 08:27:41 -0700 (PDT)
MIME-Version: 1.0
References: <20180424080437.21367-1-benjamin.tissoires@redhat.com>
 <20180424080437.21367-3-benjamin.tissoires@redhat.com> <CAKdAkRRsca1Q2Ltqr=yyZ-rr7vxkty1cGVYjFB5bcC87UtWDSw@mail.gmail.com>
In-Reply-To: <CAKdAkRRsca1Q2Ltqr=yyZ-rr7vxkty1cGVYjFB5bcC87UtWDSw@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 27 Aug 2018 17:27:28 +0200
Message-ID: <CAO-hwJ+pWUwh+enYt=GcJcyJ3rZME6DhrZ3EaY0T7iceHz=Qeg@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] HID: generic: create one input report per
 application type
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 5:45 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi Benjamin, Jiri,
>
> On Tue, Apr 24, 2018 at 1:04 AM Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> >
> > It is not a good idea to try to fit all types of applications in the
> > same input report. There are a lot of devices that are needing
> > the quirk HID_MULTI_INPUT but this quirk doesn't match the actual HID
> > description as it is based on the report ID.
> >
> > Given that most devices with MULTI_INPUT I can think of split nicely
> > the devices inputs into application, it is a good thing to split the
> > devices by default based on this assumption.
> >
> > Also make hid-multitouch following this rule, to not have to deal
> > with too many input created.
> >
> > While we are at it, fix some checkpatch complaints about converting
> > 'unsigned' to 'unsigned int'.
> >
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > ---
>
> I see a spike of user reports on Bugzilla with HID devices being
> broken on 4.18 that seem to point to this commit. For example:
> https://bugzilla.kernel.org/show_bug.cgi?id=200849

Thanks Dmitry. I have requested logs from the reporters. It is
possible that the device will get split in 2: one for the pointer and
one for the buttons, and systemd would have no clue on how to handle
those cases. Depending on the logs, I'll see how we can fix that in a
clean way.

Cheers,
Benjamin
