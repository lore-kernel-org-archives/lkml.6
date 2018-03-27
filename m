Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48miU6waGUUjepouDD5VVOVLAv02UoZWyUSEkQbUxkh/Zsziq55yAJUmzDJGgHjDuruNtwL
ARC-Seal: i=1; a=rsa-sha256; t=1522168393; cv=none;
        d=google.com; s=arc-20160816;
        b=DNP6xJCURRfePwVJbzSuJzdXlIwGjTTVVX4dXtpd4XFK68qlWKs45CuziQqtXd7cbN
         PY7h01q/zNn2VRYJv4Owkdw0MNDHpAMu+3gJ2QfisY1chYHgBiIu2m/Qz9hWqpX3kk+E
         1i2GIn4xHVxbQ0vYOLfMRXvNJ1xUm50Rr7fMlhDvCCfSJEjQuJgvzwXXMId5ZFBxCQTL
         Pgpp6SEKyvq6vKNB70DXQnDgsoXrYUYuV+VRu0nSv8yEtilu22uS9Q0yu+VhoCjk3yzI
         A1cU4mMEL+byJ/7p4DVf66frjwldqLO3AKW8dLTD/RTIEwX7Itt41Cp4SF6lsFmGAfol
         ZY7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0AK0UeJjyN0XcGdG9n1rN4ZutOvQKbLdnSkUUxdirv4=;
        b=fhIIaH9c1df2/Tb68NMtxWmp5tn151A4pD8/HcDsJJmvJTBPv/cb9a8QuRWu2aggqO
         JFN/zfflkyBY/qedEwCzbpfyPqNHLxjzNmnOOLhthAm73K4VFFJUDh9cx7pVyBz5NqvW
         6EMD2CpR5VChJyiPEq9USbtx+WceqWDOX6m9xwLi0JQ5kO2PSg4n5XAsp3s85jkGxlIb
         JGjez03PHedTHjpdz4Y8gzDrq6zp4NvpxHjCoVHS0ny2hpPGzNUejHduhTnvN9SPsvqM
         f7JoA6BsuN47X7skX+4lFYYY7Z7io7fCXGgcXk2zIJNiSTkK3HkphXAsyuK/kbbdKtaO
         vilw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 4.9 42/67] staging: ncpfs: memory corruption in ncp_read_kernel()
Date: Tue, 27 Mar 2018 18:27:34 +0200
Message-Id: <20180327162729.358274883@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162726.702411083@linuxfoundation.org>
References: <20180327162726.702411083@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109021146013259?=
X-GMAIL-MSGID: =?utf-8?q?1596109245234150522?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>

commit 4c41aa24baa4ed338241d05494f2c595c885af8f upstream.

If the server is malicious then *bytes_read could be larger than the
size of the "target" buffer.  It would lead to memory corruption when we
do the memcpy().

Reported-by: Dr Silvio Cesare of InfoSect <Silvio Cesare <silvio.cesare@gmail.com>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ncpfs/ncplib_kernel.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/fs/ncpfs/ncplib_kernel.c
+++ b/fs/ncpfs/ncplib_kernel.c
@@ -980,6 +980,10 @@ ncp_read_kernel(struct ncp_server *serve
 		goto out;
 	}
 	*bytes_read = ncp_reply_be16(server, 0);
+	if (*bytes_read > to_read) {
+		result = -EINVAL;
+		goto out;
+	}
 	source = ncp_reply_data(server, 2 + (offset & 1));
 
 	memcpy(target, source, *bytes_read);
