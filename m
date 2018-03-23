Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvmBnmt7gMyN4+is2qrudw3WCP8S+pPqVUBZWJCoaAj+m4hp3gTtBreMz/icWjOXVeJeKSj
ARC-Seal: i=1; a=rsa-sha256; t=1521800336; cv=none;
        d=google.com; s=arc-20160816;
        b=eOEPJZWvSK+dzBdWaDVFybb5hWItC9nUSFYiYdUPg9/MGre2bEkZ01W7Hxn8Y+B4HL
         n360sX5Vn1gtG7quTyaifU5DS0b4ru40pDojGVi7dyRfbVJbIEiHwGwowLI3GWtULePZ
         rvfquOAVg1VuzuMgxr7MG/o4grMChBpI8/10l/dli4lqVjzAPSnqgcR2U1OkJd5YNU7J
         6zK2OOKys/DDT8bFGl7H6Af2xH8pLcqaC1D1ABHPeUC8XT5QmmvWoQ4d13HwxIQ8EeGc
         Z2mqNiOUlNJOpFBfAq+F02XZdXR0WOIl45heTVdUHN7y1SIlZZOYru/YnNczP6uhpV4U
         /ObA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=UJnU0rAC3sm9tGG4Vq4Itf4z93ukuifWZzrXGa7rKLQ=;
        b=Ai3/NBv2LAsF2Rp7WlmZCNUbJhkgOWg7yl8YDwnHNEEHdbXdGpGIgot+GqqRVRqqvb
         zDQmWfS8QZHzdlxrRbX9Q8SyOx/kUvvjxFwXGs33Ef9JMds9fdcvv4KQirbdau8gWfkC
         TBCRRo8zi8jQwGlMnCPpcyZkG3aahMh+52tbZe0Bv0kMbduCjKI/tHJ/gc1ZejtOG3sf
         bpYBBrtEIEGzXbWJz40rJxI5t87U0mgpBQX++Edo/hSMNS9QWMrhoUgrfKfbBID+ma0S
         OiuQIOoFMRqaI/bl52qShEbDWGt1cOzgRvQRj+2iIhJXrEDDNfScCm82GOY7d0kdHose
         4kHA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Guoqing Jiang <gqjiang@suse.com>,
	NeilBrown <neilb@suse.com>,
	Shaohua Li <shli@fb.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 32/47] md/raid10: skip spare disk as first disk
Date: Fri, 23 Mar 2018 10:55:23 +0100
Message-Id: <20180323094249.494439158@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094248.117679641@linuxfoundation.org>
References: <20180323094248.117679641@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722709083060943?=
X-GMAIL-MSGID: =?utf-8?q?1595723309390522257?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shaohua Li <shli@fb.com>


[ Upstream commit b506335e5d2b4ec687dde392a3bdbf7601778f1d ]

Commit 6f287ca(md/raid10: reset the 'first' at the end of loop) ignores
a case in reshape, the first rdev could be a spare disk, which shouldn't
be accounted as the first disk since it doesn't include the offset info.

Fix: 6f287ca(md/raid10: reset the 'first' at the end of loop)
Cc: Guoqing Jiang <gqjiang@suse.com>
Cc: NeilBrown <neilb@suse.com>
Signed-off-by: Shaohua Li <shli@fb.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/raid10.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -4132,6 +4132,7 @@ static int raid10_start_reshape(struct m
 				diff = 0;
 			if (first || diff < min_offset_diff)
 				min_offset_diff = diff;
+			first = 0;
 		}
 	}
 
